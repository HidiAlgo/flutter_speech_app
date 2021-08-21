import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_app/screens/initialScreen.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => InitialScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1,0.5,0.9],
          colors: [Color(0xFFF7CAD0),Color(0xFFFF5C8A),Color(0xFFFBB1BD)]
        )
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Image.asset("assets/splash_logo1.png",width: 300,),
          ),
      ),
    );
  }
}
