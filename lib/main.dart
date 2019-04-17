import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String urlLuces = 'http://192.168.0.98:3000/luces/';

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
  bool _loadingLuzCentral = false;
  bool _loadingLuzLateral = false;

  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      key: mScaffoldState,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 20.0, bottom: 20.0),
              color: Colors.purple,
              onPressed: !_loadingLuzCentral ? _onChangeLuzCentral : null,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0)),
              child: Center(
                child: !_loadingLuzCentral
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
            SizedBox(height: 50.0),
            RaisedButton(
              padding: EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 20.0, bottom: 20.0),
              color: Colors.amberAccent,
              onPressed: !_loadingLuzLateral ? _onChangeLuzLateral : null,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0)),
              child: Center(
                child: !_loadingLuzLateral
                    ? Text(
                        'LUCES LATERALES',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangeLuzCentral() {
    toggleLuz('central');
  }

  void _onChangeLuzLateral() {
    toggleLuz('lateral');
  }

  Future toggleLuz(String tipo) async {
    try {
      var obj = {"name": "central", "state": "true"};
      if (tipo == 'lateral') {
        obj = {"name": "lateral", "state": "true"};

        setState(() {
          _loadingLuzLateral = true;
        });
      } else {
        setState(() {
          _loadingLuzCentral = true;
        });
      }

      var head = {"Accept": "application/json"};
      final response = await http.post(urlLuces, body: obj, headers: head);
      if (response.body != null) {
        createSnackBar('OK !');
        setState(() {
          _loadingLuzCentral = false;
          _loadingLuzLateral = false;
        });
      }
    } catch (e) {
      print(e.toString());
      createSnackBar('Error al conectarse con el servidor ! '+e.toString());
      setState(() {
        _loadingLuzCentral = false;
        _loadingLuzLateral = false;
      });
    }
  }

  void createSnackBar(String message) {
    final snackBar =
        new SnackBar(backgroundColor: Colors.lightBlue, content: new Text(message));
    mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
