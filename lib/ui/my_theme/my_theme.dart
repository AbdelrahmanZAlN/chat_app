import 'package:flutter/material.dart';

class MyTheme {

  static const Color lightPrimaryColor=Color(0xFF243B61);

  var lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimaryColor
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),

      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 18
      )
    )

  );

}