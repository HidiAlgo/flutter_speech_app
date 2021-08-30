import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_app/Const/Constants.dart';
import 'package:speech_app/screens/main_screen.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

const MaterialColor datePickerTheme = MaterialColor(0xffffff, <int, Color>{
  50: Color(0xFFFF5C8A),
  100: Color(0xFFFF5C8A),
  200: Color(0xFFFF5C8A),
  300: Color(0xFFFF5C8A),
  400: Color(0xFFFF5C8A),
  500: Color(0xFFFF5C8A),
  600: Color(0xFFFF5C8A),
  700: Color(0xFFFF5C8A),
  800: Color(0xFFFF5C8A),
  900: Color(0xFFFF5C8A),
});

class _InitialScreenState extends State<InitialScreen> {
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  GlobalKey<FormState> _nickNameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _ageFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _pDateFormKey = GlobalKey<FormState>();

  Future<SharedPreferences> _mSF = SharedPreferences.getInstance();

  Future<void> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(_date.year - 1),
        lastDate: DateTime(_date.year + 1),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.pink,
            ),
            child: child,
          );
        });

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        String formattedDate = DateFormat("yyyy-MM-dd").format(_datePicker);
        _dateController.text = formattedDate;
      });

      print(_date.year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
            0.1,
            0.5,
            0.9
          ],
              colors: [
            Color(0xFFF7CAD0),
            Color(0xFFFF5C8A),
            Color(0xFFFBB1BD)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/logonew.png',
                      width: 100,
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  Container(
                    child: Image.asset(
                      'assets/mothernew.png',
                      width: 180.0,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _nickNameFormKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: _nickNameController,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          filled: true,
                          fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                          hintText: "Nick Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _ageFormKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: _ageController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          filled: true,
                          fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                          hintText: "Age",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _pDateFormKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                          hintText: "Pregnancy Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: _dateController,
                        onTap: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else
                            return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xFFF7CAD0).withOpacity(0.4),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFFF5C8A),
                      ),
                    ),
                    onTap: () {
                      //todo validation data
                      if (_isValidate()) {
                        var nickname = _nickNameController.text;
                        var age = _ageController.text;
                        var pDate = _dateController.text;

                        //todo storing data in shared preferences
                        setDataToSP(nickname, age, pDate);

                        //todo moving to main
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => MainScreen()));
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  bool _isValidate() {
    if (!_nickNameFormKey.currentState.validate()) {
      return false;
    } else if (!_ageFormKey.currentState.validate()) {
      return false;
    } else if (!_pDateFormKey.currentState.validate()) {
      return false;
    } else {
      return true;
    }
  }

  Future<Null> setDataToSP(String nickName, String age, String pDate) async {
    final SharedPreferences prefs = await _mSF;

    prefs.setString(Constants.NICK_NAME, nickName);
    prefs.setInt(Constants.AGE, int.parse(age));
    prefs.setString(Constants.P_DATE, pDate);
  }
}
