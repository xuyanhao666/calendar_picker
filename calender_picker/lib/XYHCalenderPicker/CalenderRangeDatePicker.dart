import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class CalenderRangeDatePicker extends StatefulWidget {
  CalenderRangeDatePicker({Key key, this.beginTime, this.endTime, this.clickCallback})
      : super(key: key);
  final String beginTime;
  final String endTime;
  final Function(DatePeriod period) clickCallback;
  @override
  _CalenderRangeDatePickerState createState() => _CalenderRangeDatePickerState();
}

class _CalenderRangeDatePickerState extends State<CalenderRangeDatePicker> {
  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;

  static const Color selectedPeriodStartColor = Colors.blueAccent;
  static const Color selectedPeriodLastColor = Colors.blueAccent;
  static const Color selectedPeriodMiddleColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();

    _firstDate = DateTime.now().subtract(Duration(days: 9999));
    _lastDate = DateTime.now().add(Duration(days: 9999));

    DateTime selectedPeriodStart = DateTime.parse(widget.beginTime.substring(0,10));
    DateTime selectedPeriodEnd = DateTime.parse(widget.endTime.substring(0,10));

    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    // selectedPeriodLastColor = Theme.of(context).accentColor;
    // selectedPeriodMiddleColor = Colors.yellowAccent;
    // selectedPeriodStartColor = Theme.of(context).accentColor;
  }

  // add selected colors to default settings
  DatePickerRangeStyles styles = DatePickerRangeStyles(
    selectedPeriodLastDecoration: BoxDecoration(
        color: selectedPeriodLastColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0))),
    selectedPeriodStartDecoration: BoxDecoration(
      color: selectedPeriodStartColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
    ),
    selectedPeriodMiddleDecoration: BoxDecoration(
        color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: new BoxDecoration(
              //背景
              color: Colors.white,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //设置四周边框
              // border: new Border.all(width: 1, color: Colors.red),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(20.0),
            height: 380,
            child: Column(
              children: <Widget>[
                RangePicker(
                  selectedPeriod: _selectedPeriod,
                  onChanged: _onSelectedDateChanged,
                  firstDate: _firstDate,
                  lastDate: _lastDate,
                  datePickerStyles: styles,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        '取消',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      child: Text(
                        '确定',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        if (widget.clickCallback != null) {
                          widget.clickCallback(_selectedPeriod);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriod = newPeriod;
    });
  }
}
