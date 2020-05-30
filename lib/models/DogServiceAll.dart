import 'dart:convert';
 
import 'package:covid_19/models/character_data_all.dart';
import 'package:http/http.dart' as Http;
 
class DogServiceAll {
  static Future<Character_data_all> randomDog() async {
    var url = "https://covid19.th-stat.com/api/open/timeline";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    print(map);
    Character_data_all msg = Character_data_all.fromJson(map);
    return msg;
  }
}