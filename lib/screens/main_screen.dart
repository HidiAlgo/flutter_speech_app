import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_app/Const/Constants.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool isListening = false;
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = 'Hello Emely \n How can i help You?';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = 'en_US';
  final SpeechToText speech = SpeechToText();

  //INITIALIZE THE SPEECH INSTANCE
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));


    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //INITIALIZE THE SPEECH INSTANCE WHEN APPLICATION STARTED
    initSpeechState();

  }
  @override
  Widget build(BuildContext context) {
    //MAIN WINDOW USER INTERFACES
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
                    Text( !isListening ? "TAP START TO SPEECH" : "LISTENING!", style: TextStyle(
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
                      duration: Duration(milliseconds: 800),
                      repeatPauseDuration: Duration(milliseconds: 600),
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

                            //STARTING BUTTON GLOWER AND SOUND LISTENER
                            if(!isListening){
                              setState(() {
                                isListening = true;
                                startListening();
                              });

                            }else{
                              //STOPPING BUTTON GLOWER AND LISTENER WHEN PRESSING AGAIN
                              setState(() {
                                isListening = false;
                                speech.stop();
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      //HERE SHOW THE RECOGNIZED TEXT FROM LISTENER
                      child: Text(lastWords,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ),
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

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      if(error.permanent){
        lastError = error.errorMsg;
        isListening = false;
        Constants.showToast("Speech time out");
      }
      lastError = '${error.errorMsg}';
    });

  }


  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

    //SPEECH LISTENER
  void startListening() {
    setState(() {
      isListening = true;
    });

    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {

      lastWords = '${result.recognizedWords}';
      isListening = !result.finalResult;//button glowing is ended when the stop speeching.

      if(result.finalResult){
        postAPIRequest();
      }

    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }


  void postAPIRequest(){
    // todo CALL VOICE FLOW API
    print(lastWords);
  }
}

