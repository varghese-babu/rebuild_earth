import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_bundle/background1.dart';
import 'package:flutter_ui_bundle/registerUI.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

 Future<Post> fetchPost() async {
  final response =
      await http.get('https://api.rebuildearth.org/api/accounts/register');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
    SystemChrome.setEnabledSystemUIOverlays([]);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  MyHomePage1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Background(),
            Register(),
          ],
        ));
  }
}
class Post {
  final String username;
  final String email;
  final String password;
  final BigInt phone;

  Post({this.username, this.email, this.password, this.phone});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}
