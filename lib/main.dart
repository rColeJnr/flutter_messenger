import 'package:flutter/material.dart';
import 'package:flutter_messenger/helper/authenticate.dart';
import 'package:flutter_messenger/helper/helperfunctions.dart';
import 'package:flutter_messenger/views/chatrooms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedState().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter chat",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff145C9E),
            scaffoldBackgroundColor: Color(0xff1F1F1F1F),
            accentColor: Color(0xff007EF4),
            fontFamily: "OverpassRegular",
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: userIsLoggedIn != null
            ? userIsLoggedIn
                ? ChatRoom()
                : Authenticate()
            : Container(
                child: Center(
                  child: Authenticate(),
                ),
              ));
  }
}
