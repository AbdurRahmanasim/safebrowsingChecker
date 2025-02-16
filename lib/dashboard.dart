import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webchecker/webController.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebController>(builder: (context, webController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("DASHBOARD"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("DASHBOARD"),
              Text(webController.apiResponse.toString())
            ],
          ),
        ),
      );
    });
  }
}
