import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;

  Profile(this.name);
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
    );
  }
}
