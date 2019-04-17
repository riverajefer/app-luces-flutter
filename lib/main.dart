import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = 'http://192.168.0.19:3000/luces/';
String urlStatus = 'http://192.168.0.19:3000/luces/';
String urlLuces = 'http://192.168.0.19:3000/luces/';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOME LUCES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'HOME LUCES'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _loading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.only(
                  left: 75.0, right: 75.0, top: 25.0, bottom: 25.0),
              color: Colors.purple,
              onPressed: _toggleLuz,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0)),
              child: Container(
                child: !_loading
                    ? Text(
                        'LUZ CENTRAL',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      )
                    : CircularProgressIndicator(),
              ),
            ),
            Text(
              '',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<String> _toggleLuz() async {
    setState(() {
      // _loading = true;
    });

    var obj = {"name": "central", "state": "true"};
    final response = await http
        .post(urlLuces, body: obj, headers: {"Accept": "application/json"});
    // final response = await http.get('http://192.168.0.19:3000/luces/');

    print('response: ' + response.body);

    return "";
  }
}
