import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(color: Colors.lightBlue),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
          headlineMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)
      )
  );
}