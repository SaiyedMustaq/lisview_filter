import 'dart:async';

import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Listview Filter'))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/splashlogo.png"),
    );
  }
}
