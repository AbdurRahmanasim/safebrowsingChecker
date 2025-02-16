import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  String name, address, timings, offer, description;
  int contact;
  DetailedView(
      {super.key,
      required this.name,
      required this.address,
      required this.timings,
      required this.offer,
      required this.description,
      required this.contact});

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed View"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.name),
            Text(widget.address),
            Text(widget.timings),
            Text(widget.offer),
            Text(widget.description),
            Text(widget.contact.toString()),
          ],
        ),
      ),
    );
  }
}
