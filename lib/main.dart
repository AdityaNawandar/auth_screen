import 'package:auth_screen/constants.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //defines textfield style
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white38,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * 1.2, horizontal: kDefaultPadding),
        ),
      ),
      home: AuthScreen(),
    );
  }
}
