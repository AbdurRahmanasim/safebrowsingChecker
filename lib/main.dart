import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController weburlController = TextEditingController();

  bool apiResponse = true;

  checkWebsite() async {
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
        setState(() {
          apiResponse = true;
        });
      } else {
        apiResponse = false;
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("WEBCHECKER"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("CHECK WEBSITES AUTHENTICITY"),
              SizedBox(
                width: width / 1.4,
                child: TextField(
                  controller: weburlController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter link URL"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    checkWebsite();
                  },
                  child: Text("Check Website")),
              apiResponse
                  ? Text("WEBSITE IS SAFE ")
                  : Text("WEBSITE IS NOT SAFE "),
            ],
          ),
        ),
      ),
    );
  }
}
