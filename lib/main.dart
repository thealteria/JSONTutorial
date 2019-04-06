import 'package:flutter/material.dart';
import './ui/list_builder.dart';
import './ui/list_seperated.dart';

void main() async {
  runApp(
    new MaterialApp(
      title: "JSON Parse",
      home: new ListSeparated(),
    ),
  );
}
