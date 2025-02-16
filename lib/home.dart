import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webchecker/dashboard.dart';
import 'package:webchecker/webController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weburlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<WebController>(builder: (context, webController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HOME"),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ));
                  },
                  child: Text("GO TO DASHBOARD")),
              ElevatedButton(
                  onPressed: () {
                    webController.checkWebsite(weburlController);
                  },
                  child: Text("Check Website")),
              webController.apiResponse
                  ? Text("WEBSITE IS SAFE ")
                  : Text("WEBSITE IS NOT SAFE "),
            ],
          ),
        ),
      );
    });
  }
}
