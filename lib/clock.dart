import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'dart:async';
import 'package:clock_28hr/util.dart';

const String androidWidgetName = 'ClockWidget';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() {
    return _ClockState();
  }
}

class _ClockState extends State<Clock> {
  String timeIn28Hr = get28HourClockTime();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      String timeNow = get28HourClockTime();
      setState(() {
        timeIn28Hr = timeNow;
      });

      HomeWidget.saveWidgetData<String>('time_now', timeNow.substring(0, 8));
      HomeWidget.updateWidget(
        androidName: androidWidgetName,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            timeIn28Hr,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
