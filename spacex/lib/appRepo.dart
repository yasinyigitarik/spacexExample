import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppRepo with ChangeNotifier {
  var data;

  getSpacexData(context) {
    http.get(
      Uri.parse('https://api.spacexdata.com/v4/launches/latest'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      var _incomingData = json.decode(value.body);
      // print(_incomingData['success']);

      if (_incomingData['success'] == true) {
        data = _incomingData;
      }

      notifyListeners();
    });
  }
}
