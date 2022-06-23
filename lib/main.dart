import 'package:flutter/material.dart';
import 'package:productivity_app/timer_home_page.dart';

void main() =>
  runApp(const MyApp ());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Work Timer",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
     home: TimerHomePage()
    );
  }
}

