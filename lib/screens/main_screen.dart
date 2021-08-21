import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _mainText = "TAP START TO SPEECH";
  bool _mIsListening = true;
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
        body: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: (){
                              //todo go to the setting
                            },
                            child: Image.asset("assets/setting_icon.png",height: 36,),
                          ),
                        )

                      ],
                    ),
                    Text(_mainText, style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 70,),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9BEC7).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                        /*InkWell(
                          onTap: (){
                            //todo start speeching
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFFF9BEC7),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(
                                child: Text("START",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                            ),
                          ),
                        )*/
                        AvatarGlow(
                          animate: _mIsListening,
                          glowColor: Colors.blue,
                          endRadius: 75.0,
                          duration: Duration(milliseconds: 2000),
                          repeatPauseDuration: Duration(milliseconds: 100),
                          repeat: true,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFFF9BEC7),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(
                              child: Text("START",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 100,),
                    Text("Hello Emely \n How can i help You?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ),
                    ),


                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
/*
AvatarGlow(
animate: _mIsListening,
glowColor: Colors.blue,
endRadius: 75.0,
duration: Duration(milliseconds: 2000),
repeatPauseDuration: Duration(milliseconds: 100),
repeat: true,
child: Container(
width: 150,
height: 150,
decoration: BoxDecoration(
color: Color(0xFFF9BEC7),
borderRadius: BorderRadius.circular(100)
),
child: Center(
child: Text("START",
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold
),
),
),
),
),
*/
