import 'package:calender_picker/XYHCalenderPicker/CalenderDayDatePicker.dart';
import 'package:calender_picker/XYHCalenderPicker/CalenderRangeDatePicker.dart';
import 'package:calender_picker/XYHCalenderPicker/PushAnnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String beginTime = 'defalutTime';
  String endTime = 'defalutTime';
  String selectedTime = 'defalutTime';

  @override
  void initState() {
    super.initState();
    beginTime = DateTime.now().toString();
    endTime = DateTime.now().add(Duration(days: 7)).toString();

    selectedTime = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CustomRouteZoom(CalenderDayDatePicker(
                      selectedTime: selectedTime,
                      clickCallback: _dateChanged,
                    )));
              },
              tooltip: 'Day Picker',
              child: Icon(Icons.add),
            ), //
            FloatingActionButton(
              heroTag: 'secend',
              onPressed: () {
                Navigator.push(
                    context,
                    CustomRouteZoom(CalenderRangeDatePicker(
                      beginTime: beginTime,
                      endTime: endTime,
                      clickCallback: _rangeDateChanged,
                    )));
              },
              tooltip: 'Range Date Picker',
              child: Icon(Icons.add),
            ),

            Container(
                margin: EdgeInsets.all(10.0),
                color: Colors.yellowAccent,
                child: Text(
                  'selectedTime:$selectedTime\n beginTime:$beginTime\n endTime:$endTime',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }

  void _dateChanged(DateTime dateTime) {
    selectedTime = dateTime.toString();
    setState(() {});
    //调用全部节点接口
  }

  void _rangeDateChanged(DatePeriod dateTime) {
    beginTime = dateTime.start.toString();
    endTime = dateTime.end.toString();
    setState(() {});
  }
}
