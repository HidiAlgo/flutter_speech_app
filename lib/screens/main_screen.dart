import 'dart:convert';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_app/Const/Constants.dart';
import 'package:speech_app/Const/musicVisualizer.dart';
import 'package:speech_app/api/network.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayer/audioplayer.dart';

import 'dart:math';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool isListening = false;
  bool isSpeeching = false;
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = 'en_US';
  String nickName = '';
  int age = 0;
  String pregnantDate = '';


  bool id = false;
  var idNumber = "";

  bool music = false;
  AudioPlayer audioPlayer;

  final SpeechToText speech = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  DateTime _date = DateTime.now();

  Future<SharedPreferences> _mSF = SharedPreferences.getInstance();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();



  void getDataFromSF() async {
    final SharedPreferences prefs = await _mSF;
    nickName = prefs.getString(Constants.NICK_NAME);
    age = prefs.getInt(Constants.AGE);
    pregnantDate = prefs.getString(Constants.P_DATE);
    lastWords = 'Hello $nickName \n How are you today?';


  }

  Future<Null> setDataToSP(String nickName,String age,String pDate)  async {
    final SharedPreferences prefs = await _mSF;

    prefs.setString(Constants.NICK_NAME, nickName);
    prefs.setInt(Constants.AGE, int.parse(age));
    prefs.setString(Constants.P_DATE, pDate);

  }


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
    getDataFromSF();


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
                              _showEditProfileDialog();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset("assets/setting_icon.png",width: 30,height: 30,)
                            ),
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

                    SizedBox(height: 40,),
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
                    SizedBox(height: 120,),
                    Visibility(
                        child: MusicVisualizer(),
                        visible: isSpeeching,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                    )
                    ,

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
      // print('$eventTime $eventDescription');
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

  // THIS FUNCTION CAN BE USED TO  PLAY A MUSIC
  void playMusic(String url){
    audioPlayer = AudioPlayer();
    audioPlayer.play(url);
    print(url);
    music = true;

  }

  // THIS FUNCTION IS USED TO STOP THE PLAYING MUSIC
  void stopMusic(){
    if(music == true){
      audioPlayer.stop();
      textToSpeech("I stopped the music for you");
      music = false;
    }else{
      textToSpeech("Sorry there is no music");
    }
  }

  void postAPIRequest(){
    // todo CALL VOICE FLOW API
    // GENERATING A RANDOM INTEGER FOR THE USER ID ONLY AT THE START OF THE APP
    if(id == false){
      Random random = new Random();
      var randomNumber1 = random.nextInt(900000) + 100000;
      var randomNumber2 = random.nextInt(900000) + 100000;

      idNumber = randomNumber1.toRadixString(16) + randomNumber2.toRadixString(16);
      id = true;

    }

    // IF A BACKGROUND MUSIC IS PLAYING, USING THE COMMAND 'STOP THE MUSIC' WILL STOP IT.
    if(lastWords == "stop the music"){
      stopMusic();
    }else{
      NetworkHelper().getVoice(lastWords,getResponseDataFromApi, idNumber);
    }
  }


  // AFTER THE CALLING API RESPONSE DATA COMES TO THIS METHOD FROM NETWORK HELPER CLASS, IF RESPONSE STATUS SUCCESS
  void getResponseDataFromApi(String response){
    //RESPONSE IS STRING, THAT CONVERTING TO JSON FORMAT
    var jsonData = jsonDecode(response);

    //CREATING THE STRING FOR THE SPEAKING
    var str = "";
    print(jsonData);
    for( var i = 0 ; i < jsonData.length; i++ ) {
      print(jsonData[i]);
      if(jsonData[i]['type'] == 'speak'){
        str += jsonData[i]['payload']['message']+". ";
        if(jsonData[i]['payload']['type'] == 'audio'){
          playMusic(jsonData[i]['payload']['src']);
        }

      }
    }


    textToSpeech(str);

    str = "";




  }


  //SHOWING THE EDIT PROFILE CUSTOM DIALOG
  void _showEditProfileDialog(){
    _nickNameController.text = nickName;
    _ageController.text = age.toString();
    _dateController.text = pregnantDate;

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        title: Center(child: Text("Edit Profile",style: TextStyle(color: Color(0xFFFF5C8A)),)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nickNameController,
              decoration: InputDecoration(
                labelText: "NickName",

              ),
            ),

            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: "Age",

              ),
            ),

            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",

              ),
              onTap: (){
                setState(() {
                  _selectDate(context);
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        setDataToSP(_nickNameController.text,_ageController.text,_dateController.text);
                      });

                      Navigator.of(context).pop();

                    }, child: Text("Save"),),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("Cancel")),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> _selectDate(BuildContext context)async{
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(_date.year-1),
        lastDate: DateTime(_date.year+1),

        builder: (BuildContext context,Widget child){
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.pink,


            ),
            child: child,
          );
        }
    );



    if(_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        String formattedDate = DateFormat("yyyy-MM-dd").format(_datePicker);
        _dateController.text = formattedDate;
      });

      print(_date.year);
    }
  }

  //SPEECHING PROVIDED TEXT
  void textToSpeech(String text) async{
    flutterTts.setStartHandler(() {
      setState(() {

        isSpeeching = true;

      });
    });
    print("tts called");
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(0.8);  //0.5 to 1.5
    await flutterTts.speak(text);

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        isSpeeching = false;

      });
    });
  }
}

