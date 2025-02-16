import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webchecker/dashboard.dart';
import 'package:webchecker/detailedView.dart';
import 'package:webchecker/webController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weburlController = TextEditingController();

  List business = [
    {
      "name": "Pro Laptops",
      "address": "Saddar, karachi",
      "contact": 123456789,
      "timings": "9am-9pm",
      "description": "All variety of laptops available",
      "offer": "20% OFF",
    },
    {
      "name": "Pro Chargers",
      "address": "Saddar, karachi",
      "contact": 123456789,
      "timings": "9am-9pm",
      "description": "All variety of charger available",
      "offer": "10% OFF",
    },
    {
      "name": "Pro Mobiles",
      "address": "Saddar, karachi",
      "contact": 123456789,
      "timings": "9am-9pm",
      "description": "All variety of Mobiles available",
      "offer": "15% OFF",
    },
    {
      "name": "Pro Computers",
      "address": "Saddar, karachi",
      "contact": 123456789,
      "timings": "9am-9pm",
      "description": "All variety of computers available",
      "offer": "30% OFF",
    },
  ];

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
              ListView.builder(
                itemCount: business.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => DetailedView(name: business[index]["name"], address: business[index]["address"] , contact: business[index]["contact"], description: business[index]["description"], offer: business[index]["offer"], timings: business[index]["timings"],   ),));
                    },
                    title: Text(business[index]["name"]),
                    subtitle: Text(business[index]["address"]),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
