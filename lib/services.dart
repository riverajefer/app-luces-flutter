import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = 'https://jsonplaceholder.typicode.com/posts';

Future<String> toggleLuz() async {
  var obj = {"name": "central", "state": true};
  final response =
      await http.post(url, body: obj, headers: {"Accept": "application/json"});

  if(response.statusCode==200) {
    print('Todo ok');
  } else {
    print('Error');
  }
}
