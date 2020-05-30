import 'dart:convert';
 
import 'package:covid_19/models/character_data.dart';
import 'package:http/http.dart' as Http;
 
class DogService {
  static Future<CharacterData> randomDog() async {
    var url = "https://covid19.th-stat.com/api/open/today";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    CharacterData msg = CharacterData.fromJson(map);
    return msg;
  }
}