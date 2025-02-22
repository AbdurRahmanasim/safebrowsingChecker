import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:webchecker/fraudlentEmails.dart';
import 'package:webchecker/home.dart';
import 'package:webchecker/mainController.dart';
import 'package:webchecker/webController.dart';

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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => WebController(),
      ),
      ChangeNotifierProvider(
        create: (context) => Maincontroller(),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: "EMAIL CHECKER",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.red, brightness: Brightness.light),
            useMaterial3: true,
          ),
          home: FraudEmailChecker(),
        ),
      )
    ]);
  }
}
