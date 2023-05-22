// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:socketio/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket IO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocketIOScreen(),
    );
  }
}

