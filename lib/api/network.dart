import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:speech_app/Const/Constants.dart';

class NetworkHelper{
  //api key VF.612526ed078404001b53afb4.5IOnI2I3TkHzSs60dRjYv7KV2KdzHN42SuqNQ0Tl57
  //version id  610e35cf7f08be0007d07953
  //https://creator.voiceflow.com/project/610e35cf7f08be0007d07953/publish/api
  //https://general-runtime.voiceflow.com/state/{versionID}/user/{userID}/interact

  var url = "https://general-runtime.voiceflow.com/state/610e35cf7f08be0007d07953/user/user123/interact";
  //var path = "/state/610e35cf7f08be0007d07953/user/user123/interact";
  var auth = "VF.612526ed078404001b53afb4.5IOnI2I3TkHzSs60dRjYv7KV2KdzHN42SuqNQ0Tl57";
  var body = {"type": "text", "payload": "Hello world!"};
  

  NetworkHelper();

  Future<dynamic> getVoice(String voice,Function getResponseDataFromApi) async{

    Map<String,String> header = {"Authorization" : auth};
    var body = jsonEncode({"request": {"type": 'text', "payload": "$voice",}});
    

    http.Response response = await http.post(Uri.parse(url), headers: header, body: body);
    print("status code : ${response.statusCode}");

    if(response.statusCode == 200){

      print("success");
      var jsonData = jsonDecode(response.body);

      //print(jsonData);
      //print(jsonData[0]['type']);
      getResponseDataFromApi(response.body);

    }else{
      Constants.showToast("Something went wrong");
    }
  }

}