// ignore_for_file: prefer_const_constructors
import 'package:productivity_app/timermodel.dart';
import './settings.dart';
import 'timer.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/widget.dart';
import 'widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  TimerHomePage({Key? key}) : super(key: key);
  final double defaultPadding = 5.0;
  final double size = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    final List <PopupMenuItem<String>> menuItems =
    <PopupMenuItem<String>>[];
    menuItems.add (PopupMenuItem (
      value: "Settings",
      child: Text('Settings'),
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
                  if(s== 'Settings') {
                    goToSettings (context);
                  }
            },
            )
          ],
        ),
        body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double availableWidth = constraints.maxWidth;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff009688),
                text: "Work",
                onPressed: () => timer.startTimer(),
                size: size,
              )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              ProductivityButton(
                color: Color(0xff607D8B),
                text: "Short Break",
                onPressed: () => timer.startBreak(bool, true),
                size: size,
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              ProductivityButton(
                color: Color(0xff455A64),
                text: "Long Break",
                onPressed: () => timer.startBreak(bool, false),
                size: size,
              ),
            ],
          ),
          StreamBuilder(
              initialData: '00:00',
              stream: timer.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                TimerModel timer = (snapshot.data == '00:00')
                    ? TimerModel('00:00', 1)
                    : snapshot.data;
                return Expanded(
                  child: CircularPercentIndicator(
                    radius: availableWidth / 2,
                    lineWidth: 10.0,
                    percent: timer.percent,
                    center: Text(timer.time,
                        style: Theme.of(context).textTheme.headline4),
                    progressColor: Color(0xff009688),
                  ),
                );
              }),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                      color: Color(
                        0xff212121,
                      ),
                      text: 'Stop',
                      size: size,
                      onPressed: () => timer.stopTimer() ) ),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                      color: Color(
                        0xff009688,
                      ),
                      text: 'Restart',
                      size: size,
                      onPressed: () => timer.startTimer() ) )
            ],
          )
        ]),
      );
    }));
  }

  void goToSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }
}
