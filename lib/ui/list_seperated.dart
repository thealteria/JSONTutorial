import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; //help to convert and display data
import 'package:http/http.dart' as http;

class ListSeparated extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Response();
  }
}

class Response extends State<ListSeparated> {
  List data = [];
  Future<List> getData() async {
    String url = "http://jsonplaceholder.typicode.com/photos";

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    //await basically pauses execution until the get()
    //func returns a response

    setState(() {
      data = json.decode(response.body);
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Parse Json"),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: new Center(
          child: new FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: new Text("Loading..."),
              ),
            );
          } else {
            return new ListView.separated(
              itemCount: snapshot.data.length,
              padding: const EdgeInsets.all(5.0),
              scrollDirection: Axis.vertical,
              separatorBuilder: (BuildContext context, int position) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int position) {
                return new ListTile(
                  title: new Text(
                    "${snapshot.data[position]['id']}",
                    style: new TextStyle(fontSize: 14.9),
                  ),
                  subtitle: new Text(
                    "${snapshot.data[position]['title']}",
                    style: new TextStyle(
                      fontSize: 13.4,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: new CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data[position]['thumbnailUrl']),
                  ),
                  onTap: () {
                    _showAlertDialog(context, "${data[position]['id']}",
                        "${snapshot.data[position]['title']}");
                  },
                );
                // );
              },
            );
          }
        },
      )),
    );
  }
}

void _showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
