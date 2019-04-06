import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; //help to convert and display data
import 'package:http/http.dart' as http;

class ListBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Response();
  }
}

class Response extends State<ListBuilder> {
  List data = [];
  Future<List> getData() async {
    String url = "http://jsonplaceholder.typicode.com/posts";

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    //await basically pauses execution until the get()
    //func returns a response

    setState(() {
      data = json.decode(response.body);
    });

    // print(data[1]["title"]);
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
            return new ListView.builder(
              itemCount: snapshot.data.length,
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) return new Divider();
                final index = position ~/
                    2; //dividing position by 2 and returning an integer result
                return new ListTile(
                  title: new Text(
                    "${snapshot.data[index]['title']}",
                    style: new TextStyle(fontSize: 14.9),
                  ),
                  subtitle: new Text(
                    "${snapshot.data[index]['body']}",
                    style: new TextStyle(
                      fontSize: 13.4,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: new Text(
                      "${snapshot.data[index]['title'][0].toString().toUpperCase()}",
                      style: TextStyle(
                        fontSize: 19.4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    _showAlertDialog(
                        context,
                        "${snapshot.data[index]['title']}",
                        "${snapshot.data[index]['body']}");
                  },
                );
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
