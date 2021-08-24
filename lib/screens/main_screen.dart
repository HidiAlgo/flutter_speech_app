import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _speechText = "TAP START TO SPEECH";
  bool isListening = false;
  String text = "Hello Emely \n How can i help You?";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                    Text( !isListening ? _speechText : "Speeching!", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 70,),

                    AvatarGlow(
                      animate: isListening,
                      glowColor: Color(0xFFF7CAD0),
                      endRadius: 150.0,
                      duration: Duration(milliseconds: 1000),
                      repeatPauseDuration: Duration(milliseconds: 800),
                      repeat: true,
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFF7CAD0),
                        ),
                        child: new RawMaterialButton(
                          shape: new CircleBorder(),
                          elevation: 0.0,
                          child: Icon(isListening ? Icons.mic : Icons.mic_none,color: Color(0xFFFF5C8A),size: 60,),
                          onPressed: () {
                           // onListen();
                            //toggleRecording();
                            if(!isListening){
                              setState(() {
                                isListening = true;
                              });

                            }else{
                              setState(() {
                                isListening = false;
                              });
                            }
                          },
                        ),
                      ),




                    ),

                    SizedBox(height: 100,),
                    Text(text,
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

