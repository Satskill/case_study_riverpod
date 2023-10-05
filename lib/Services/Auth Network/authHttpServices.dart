import 'dart:convert';

import 'package:case_study_riverpod/main.dart';
import 'package:http/http.dart';

class authHttpServices {
  login(String email, String password) async {
    print(email);
    print(password);
    try {
      Map<String, String> header = {"content-type": "application/json"};
      Response response = await post(
          Uri.parse(
            uri + 'api/login',
          ),
          body: jsonEncode({'email': email, 'password': password}),
          headers: header);
      if (response.statusCode == 200) {
        return {
          'code': response.statusCode.toString(),
          'body': jsonDecode(response.body.toString())['token']
        };
      } else {
        return {
          'code': response.statusCode.toString(),
          'body': jsonDecode(response.body.toString())['error']
        };
      }
    } catch (e) {
      return {'code': '400', 'body': e};
    }
  }
}
