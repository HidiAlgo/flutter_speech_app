
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants{

  static const String NICK_NAME = "nickName";
  static const String AGE = "age";
  static const String P_DATE = "pDate";

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFFFF5C8A).withOpacity(0.8),
        textColor: Colors.white
    );
  }

}