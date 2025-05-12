import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/update.dart';

import 'add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  List list_color = [];
  List list_task = [];


  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (brightness) => ThemeData(
          primarySwatch: Colors.blue,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'ToDo',
            theme: theme,
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list_color = [];
  List list_task = [];
  List reminder = [];
  bool showList = false;


  Future<List> dataList() async {
    //Initializing the SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Getting the colour list
    var data2 = prefs.getStringList('color_list') ?? [];
    list_color = data2;

    //Getting the task list
    var data = prefs.getStringList('task_list') ?? [];
    list_task = data;
    print(list_task);
    print("entered set state");
    print(list_color);

    //Getting the reminder list
    var data3 = prefs.getStringList('reminder_list') ?? [];
    reminder = data3;
    print(reminder);

    return list_task;

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
              ),
              automaticallyImplyLeading: false,
              expandedHeight: 100,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'ToDo',
                        style: TextStyle(
                          fontSize: 25,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.black45,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'ToDo',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                    ],
                  ),
                  ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List>(
                future: dataList(),
                builder: (ctx,ss){
                  if(ss.hasError){
                    print('Error');
                  }
                  if(ss.hasData){
                    return Items(task:list_task, colour: list_color, reminder: reminder);

                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => add()));

        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Items extends StatefulWidget {

  final List task;
  final List colour;
  final List reminder;

  Items({this.task, this.colour, this.reminder});

  @override
  State<StatefulWidget> createState() {
    return _Items();
  }
}

class _Items extends State<Items>{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  TimeOfDay timeOfDay = null;
  DateTime dateTime = null;
  int flag;

  TimeOfDay timeConvert(String normTime) {
    int hour;
    int minute;
    String ampm = normTime.substring(normTime.length - 2);
    String result = normTime.substring(0, normTime.indexOf(' '));
    if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
      hour = int.parse(result.split(':')[0]);
      if (hour == 12) hour = 0;
      minute = int.parse(result.split(":")[1]);
    } else {
      hour = int.parse(result.split(':')[0]) - 12;
      if (hour <= 0) {
        hour = 24 + hour;
      }
      minute = int.parse(result.split(":")[1]);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  void notification(int k){
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    removeItem(k);
  }


  Color colourr(int k){
    String valueString = widget.colour[k].toString().split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    return otherColor;
  }

  Color stringColor(int k){
    String valueString = widget.colour[k].toString().split('(0x')[1].split(')')[0]; // kind of hacky..
    if(valueString == 'ff000000') {
      return Colors.white;
    }else{
      return Color(0xff000000);
    }
  }

  Future<Null> removeItem(int i) async {
    //Initializing SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Removing the colour in the list
    setState(() {
      widget.colour.remove(widget.colour[i]);
    });
    print(widget.colour);
    prefs.setStringList('color_list', widget.colour);

    //Removing the task in the list
    setState(() {
      widget.task.remove(widget.task[i]);
    });
    print(widget.task);
    prefs.setStringList('task_list', widget.task);

    //Removing the scheduled at item in list
    print(i);
    setState(() {
      widget.reminder.remove( widget.reminder[i]);
    });
    print( widget.reminder);
    prefs.setStringList('reminder_list',  widget.reminder);

    await flutterLocalNotificationsPlugin.cancel(i+1);
  }

  void updatePage(int k) {
    print('hello');
    var idd;
    var sub_id;
    if (widget.reminder[k].toString().contains('Everyday')) {
      idd = 2;
      sub_id = 0;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    } else if (widget.reminder[k].toString().contains('Every Monday')) {
      idd = 2;
      sub_id = 1;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;

      dateTime = null;

    } else if (widget.reminder[k].toString().contains('Every Tuesday')) {
      idd = 2;
      sub_id = 2;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;


    }else if (widget.reminder[k].toString().contains('Every Wednesday')) {
      idd = 2;
      sub_id = 3;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    }else if (widget.reminder[k].toString().contains('Every Thursday')) {
      idd = 2;
      sub_id = 4;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    }else if (widget.reminder[k].toString().contains('Every Friday')) {
      idd = 2;
      sub_id = 5;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    }else if (widget.reminder[k].toString().contains('Every Saturday')) {
      idd = 2;
      sub_id = 6;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    }else if (widget.reminder[k].toString().contains('Every Sunday')) {
      idd = 2;
      sub_id = 7;
      int length = widget.reminder[k].toString().length;
      String string = widget.reminder[k].toString().substring(length-7,length-1);
      timeOfDay = timeConvert(string);
      flag = 3;
      dateTime = null;

    }else if(widget.reminder[k].toString() == 'No particular time'){
      idd = 0;
      sub_id = 0;
      timeOfDay = null;
      dateTime = null;
    }else{
      idd = 1;
      sub_id = 0;
      String s = widget.reminder[k].toString();
      String sub = s.substring(7, s.length);
      List sp = sub.split("-");
      String new_string = "";
      for(int i = sp.length-1; i>0; i--){
        new_string = new_string + sp[i] + "-";
      }
      new_string = new_string + sp[0] + " " + s.substring(0,5) + ":00.000";
      dateTime = DateTime.parse(new_string);
      timeOfDay = null;
    }
    print('ids:');
    print(idd);
    print(sub_id);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
    update(
      task: widget.task[k],
      colour: colourr(k),
      reminder_id: idd,
      sub_id: sub_id,
      main_id: k,
      timeOfDay: timeOfDay,
      dateTime: dateTime,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(), // new
          shrinkWrap: true,
          itemCount: widget.task == null ? 0 : widget.task.length,
          itemBuilder: (ctx,i){
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: new Row(
                    children: <Widget>[
                      new Text('Done',
                        style: new TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Icon(Icons.done, color: Colors.white,)
                    ],
                  ),
                ),
              ),

              onDismissed: (direction)async{
                notification(i);
              },
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Card(
                  color: colourr(i),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ListTile(
                    title: Text(widget.task[i], style: TextStyle(fontWeight: FontWeight.bold, color: stringColor(i)),),
                    subtitle: new Row(
                      children: <Widget>[
                        Text('Scheduled at:  ', style: TextStyle(color: stringColor(i)),),
                        Text(widget.reminder[i], style: TextStyle(color: stringColor(i)),),
                      ],
                    ),
                    onTap: ()=> updatePage(i)
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

