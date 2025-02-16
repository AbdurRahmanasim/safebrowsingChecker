import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WebController extends ChangeNotifier {
  bool _apiResponse = true;
  bool get apiResponse => _apiResponse;

  checkWebsite(weburlController) async {
    try {
      final dio = Dio();
      final response = await dio.post(
          'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=AIzaSyAcAkhflXIy2KtRDdNtheXM4JN8qoGs5Io',
          data: json.encode({
            "client": {"clientId": "yourcompany", "clientVersion": "1.5.2"},
            "threatInfo": {
              "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING"],
              "platformTypes": ["ANY_PLATFORM"],
              "threatEntryTypes": ["URL"],
              "threatEntries": [
                {"url": weburlController.text.trim()}
              ]
            }
          }),
          options: Options(contentType: 'application/json'));
      print(response.data);

      if (response.data) {
        _apiResponse = true;
      } else {
        _apiResponse = false;
      }
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
