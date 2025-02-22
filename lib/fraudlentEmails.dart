import 'package:flutter/material.dart';
  // import 'package:http/http.dart' as http;
import 'dart:convert';


class FraudEmailChecker extends StatefulWidget {
  @override
  _FraudEmailCheckerState createState() => _FraudEmailCheckerState();
}

class _FraudEmailCheckerState extends State<FraudEmailChecker> {
  final TextEditingController _emailController = TextEditingController();
  String _result = "";


// Future<void> checkEmailReputation(String email) async {
//   final url = "https://emailrep.io/$email";
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     print("Email Reputation: ${data['reputation']}");
//     print("Blacklisted: ${data['details']['blacklisted']}");
//     print("Malicious Activity: ${data['details']['malicious_activity']}");
//   } else {
//     print("Error: Unable to fetch email reputation.");
//   }
// }

  // Spam words & phrases common in fraud emails
  final List<String> spamWords = [
    "lottery",
    "payout",
    "final message",
    "urgent",
    "click here",
    "verify your account",
    "winner",
    "free money",
    "password reset",
    "congratulations",
    "limited time",
    "act now"
  ];

  // Suspicious domains (common in scams)
  final List<String> suspiciousDomains = [
    "bit.ly",
    "tinyurl.com",
    "ow.ly",
    "goo.gl",
    "brango"
  ];

  // Function to check if the email is fraudulent
  void _checkEmail() {
    String emailText = _emailController.text.toLowerCase();
    bool isFraudulent = false;
    String reason = "";

    // Check for common spam words
    for (String word in spamWords) {
      if (emailText.contains(word)) {
        isFraudulent = true;
        reason = "Contains spam keywords: '$word'";
        break;
      }
    }

    // Check for suspicious links
    for (String domain in suspiciousDomains) {
      if (emailText.contains(domain)) {
        isFraudulent = true;
        reason = "Contains a suspicious link: '$domain'";
        break;
      }
    }

    // Check for excessive urgency (too many exclamation marks)
    if (RegExp(r"!{3,}").hasMatch(emailText)) {
      isFraudulent = true;
      reason = "Contains excessive exclamation marks!";
    }

    // Check if email pretends to be from the user (email spoofing detection)
    if (emailText.contains("pretended to be sent from your email")) {
      isFraudulent = true;
      reason = "Possible email spoofing attempt!";
    }

    setState(() {
      _result = isFraudulent
          ? "⚠️ Fraudulent Email Detected!\nReason: $reason"
          : "✅ Email is Safe.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fraudulent Email Detector")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email content...",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkEmail,
              child: Text("Check Email"),
            ),
            SizedBox(height: 10),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
