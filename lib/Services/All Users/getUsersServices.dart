import 'dart:convert';

import 'package:case_study_riverpod/main.dart';
import 'package:http/http.dart';

class getUsersServices {
  getUsers() async {
    try {
      Map<String, String> header = {"content-type": "application/json"};
      Response response = await get(
        Uri.parse(
          uri + 'api/users?page=2',
        ),
        headers: header,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString())['data'];
      }
      return;
    } catch (e) {
      return;
    }
  }
}
