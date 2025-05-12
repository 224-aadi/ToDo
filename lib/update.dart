import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'main.dart';

class update extends StatefulWidget {
  final String task;
  final Color colour;
  final int reminder_id;
  final int sub_id;
  final int main_id;
  TimeOfDay timeOfDay;
  DateTime dateTime;

  update({this.task, this.reminder_id, this.colour, this.sub_id, this.main_id, this.timeOfDay, this.dateTime});
  @override
  State<StatefulWidget> createState() {
    return _update();
  }
}

class _update extends State<update> {
  TextEditingController task;
  Color _currentColor;
  var selectedDate = 'No particular day';
  bool showColor = false;
  bool day = false;
  var _site;
  int time_flag = 0;
  var whichDay;
  var whichDaybool = false;
  List list_task = [];
  List list_color = [];
  List id = [];
  SharedPreferences prefs;
  List reminder = [];
  TimeOfDay time;
  String time2 = 'Choose Time';
  DateTime _dateTime = DateTime.now();
  String dateShow = 'Choose Date';
  int flag;

  @override
  void initState() {
    task = new TextEditingController(text: widget.task);
    _currentColor = widget.colour ;
    _site = widget.reminder_id;
    whichDay = widget.sub_id;

    if(_site == 1){
      day = true;

    }else if(_site == 2){
      whichDaybool = true;
    }

    super.initState();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void notification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/todo_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MyHomePage();
    }));
  }

  Future<void> scheduleNotification(int i, String s) async {
    print('id=' + i.toString());
    print('string= ' + s);
    var scheduledNotificationDateTime = _dateTime;
    print(scheduledNotificationDateTime);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        i, s, '', scheduledNotificationDateTime, platformChannelSpecifics);
  }

  Future<void> showDailyAtTime(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      s,
      '', //null
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeMonday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Monday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeTuesday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Tuesday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeWednesday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Wednesday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeThursday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Thursday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeFriday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Friday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeSaturday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Saturday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayAndTimeSunday(int i, String s) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      i,
      s,
      '', //null
      Day.Sunday,
      Time(time.hour, time.minute, 0),
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  void specific_day() {}

  Widget SpecificDay() {
    if (widget.dateTime != null) {
      setState(() {
        dateShow = widget.dateTime.toString();
        selectedDate = dateShow;
      });
    }

    if (day == true) {

        return RaisedButton(
          color: Colors.blue,
          onPressed: () {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  _dateTime = date;
                  setState(() {
                    widget.dateTime = date;
                    selectedDate = date.toString();
                    dateShow = selectedDate;
                  });
                  print('DateShow');
                  print(dateShow);
                  print('selectedDate');
                  print(selectedDate);
                  print(selectedDate.length);
                },
                currentTime: (widget.dateTime != null) ?
                (DateTime(
                    widget.dateTime.year,
                    widget.dateTime.month,
                    widget.dateTime.day,
                    widget.dateTime.hour,
                    widget.dateTime.minute))
                    :
                (DateTime(
                    _dateTime.year,
                    _dateTime.month,
                    _dateTime.day,
                    _dateTime.hour,
                    _dateTime.minute))
            );
            print('DateShow new');
            print(dateShow);
            print('selectedDate new');
            print(selectedDate);
          },
          child: Text(
            dateShow,
          ),
        );
      }else {
        return Container();

      }
  }

  Widget colour() {
    if (showColor == true) {
      return Center(
        child: CircleColorPicker(
          initialColor: _currentColor,
          onChanged: (color) => _currentColor = color,
        ),
      );
    } else {
      return Container(
        child: Text(""),
      );
    }
  }

  Widget weekly() {
    TimeOfDay time3;
    if (whichDaybool == true) {
      if(widget.timeOfDay != null){
        time3 = widget.timeOfDay;
        time2 = widget.timeOfDay.format(context);
      }else{
        time3 = TimeOfDay.now();
      }
      return Container(
        child: new Column(
          children: <Widget>[
            ListTile(
              title: const Text('Everyday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 0,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Monday
            ListTile(
              title: const Text('Every Monday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 1,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Tuesday
            ListTile(
              title: const Text('Every Tuesday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 2,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Wednesday
            ListTile(
              title: const Text('Every Wednesday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 3,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Thursday
            ListTile(
              title: const Text('Every Thursday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 4,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Friday
            ListTile(
              title: const Text('Every Friday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 5,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Saturday
            ListTile(
              title: const Text('Every Saturday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 6,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            //Sunday
            ListTile(
              title: const Text('Every Sunday'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 7,
                groupValue: whichDay,
                onChanged: (value) {
                  setState(() {
                    whichDay = value;
                  });
                },
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                time = await showTimePicker(
                    initialTime: time3, context: context);
                setState(() {
                  widget.timeOfDay = time;
                  time2 = time.format(context);
                });
              },
              child: Text(time2),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> update() async {

    notification();
    if(task.text.toString() != '') {
      prefs = await SharedPreferences.getInstance();

      // LIST FOR TASK
      //READING
      var data = prefs.getStringList('task_list') ?? [];
      list_task = data;
      list_task[widget.main_id] = task.text.toString();
      prefs.setStringList('task_list', list_task);


      var data2 = prefs.getStringList('color_list') ?? [];
      list_color = data2;
      list_color[widget.main_id] = _currentColor.toString();
      //write
      prefs.setStringList('color_list', list_color);

      var data4 = prefs.getStringList('reminder_list') ?? [];
      reminder = data4;

      if(_site == 1 && selectedDate != 'No particular day'){
        print('selectedDate:');
        print(selectedDate);

        String year = selectedDate.substring(0,4);
        String month = selectedDate.substring(5,8);
        String day = selectedDate.substring(8,10);
        String time = selectedDate.substring(11,16);
        String time1 = day + '-' + month + year;
        String FinalTime = time + ', ' + time1;
        reminder[widget.main_id] = FinalTime;
        prefs.setStringList('reminder_list', reminder);

        scheduleNotification(widget.main_id+1, task.text.toString());
        flag = 1;


      }else if( _site == 0){

        reminder[widget.main_id] = 'No particular time';
        prefs.setStringList('reminder_list', reminder);
        flag = 1;



      }else if(_site == 2 && whichDay == 0 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Everyday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showDailyAtTime(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 1 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Monday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeMonday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 2 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Tuesday  at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeTuesday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 3 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Wednesday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeWednesday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 4 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Thursday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeThursday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 5 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Friday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeFriday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 6 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Saturday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeSaturday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else if(_site == 2 && whichDay == 7 && time2 != 'Choose Time'){
        reminder[widget.main_id] = 'Every Sunday at $time2';
        prefs.setStringList('reminder_list', reminder);

        showWeeklyAtDayAndTimeSunday(widget.main_id+1, task.text.toString());
        flag = 1;

      }else{
        Toast.show('An Error Occurred', context, backgroundColor: Colors.red, textColor: Colors.white, gravity: Toast.TOP);
        flag = 0;
      }

      if(flag == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
      }


    }else{
      Toast.show('Please enter a task', context, backgroundColor: Colors.red, textColor: Colors.white, gravity: Toast.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 25.0, top: 30.0),
              child: TextField(
                controller: task,
                autocorrect: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  prefixIcon: Icon(Icons.today),
                  labelText: "Enter Task",
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            new Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 15)),
                Text(
                  "Show Color Picker",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        if (showColor == true) {
                          showColor = false;
                        } else {
                          showColor = true;
                        }
                      });
                    })
              ],
            ),
            colour(),
            ListTile(
              title: const Text('Do not remind'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 0,
                groupValue: _site,
                onChanged: (value) {
                  setState(() {
                    day = false;
                    whichDaybool = false;
                    _site = value;
                    print(_site);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Remind on a specific day'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 1,
                groupValue: _site,
                onChanged: (value) {
                  setState(() {
                    _site = value;
                    day = true;
                    whichDaybool = false;
                    print(_site);
                  });
                },
              ),
            ),
            SpecificDay(),
            ListTile(
              title: const Text('Remind me weekly'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 2,
                groupValue: _site,
                onChanged: (value) {
                  setState(() {
                    _site = value;
                    whichDaybool = true;
                    day = false;
                    print(_site);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: weekly(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          update();
        },
        child: Icon(Icons.done, color: Colors.black,),
      ),
    );
  }
  void _onColorChanged(Color color) {
    setState(() => _currentColor = color);
  }
}
