import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_joker_app/joker.dart';

class Service {
  static const String url = 'http://api.icndb.com/jokes/random/';

  static Future<Joker> getJoker() async {
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return parse(response.body);
      }else{
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Joker parse(String body) {
    final parse = json.decode(body);
    return Joker.fromJson(parse);
  }
}
