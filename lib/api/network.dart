import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:speech_app/Const/Constants.dart';


class NetworkHelper{
  //api key VF.612526ed078404001b53afb4.5IOnI2I3TkHzSs60dRjYv7KV2KdzHN42SuqNQ0Tl57
  //version id  610e35cf7f08be0007d07953
  //https://creator.voiceflow.com/project/610e35cf7f08be0007d07953/publish/api
  //https://general-runtime.voiceflow.com/state/{versionID}/user/{userID}/interact

  NetworkHelper();

  Future<dynamic> getVoice(String voice,Function getResponseDataFromApi, String id) async{

    print(voice);

    var auth = "VF.612526ed078404001b53afb4.5IOnI2I3TkHzSs60dRjYv7KV2KdzHN42SuqNQ0Tl57";
    Map<String,String> header = {"Authorization" : auth, "Content-Type": "application/json"};
    // var body = jsonEncode({"request": {"type": 'text', "payload": "$voice",}});

    var body = jsonEncode({
      "request": {
        "type": "text",
        "payload": voice
      }
    });

    var url = Uri.parse("https://general-runtime.voiceflow.com/state/610e35cf7f08be0007d07953/user/"+id+"/interact");

    var response = await http.post(url, headers: header, body: body);
    print("status code : ${response.statusCode}");

    if(response.statusCode == 200){
      print("success");
      getResponseDataFromApi(response.body);
    }else{
      Constants.showToast("Something went wrong");
    }
  }

}