import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData appLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    shadowColor: Colors.grey.shade100,
    scaffoldBackgroundColor: Colors.purple[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[50],
      titleTextStyle: TextStyle(
        color: Colors.purple[900],
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      elevation: 0,
      surfaceTintColor: Colors.purple[50],
    ),
    iconTheme: IconThemeData(color: Colors.purple[900]),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: Colors.purple[900],
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
          color: Colors.purple[50],
        ),
      ),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: Colors.purple[50],
      elevation: 0.0,
    ),
  );

  ThemeData appDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.purple[900],
    shadowColor: Colors.grey.shade700,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[900],
      titleTextStyle: TextStyle(
        color: Colors.purple[50],
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      elevation: 0,
      surfaceTintColor: Colors.purple[900],
    ),
    iconTheme: IconThemeData(color: Colors.purple[50]),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: Colors.purple[50],
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[50],
        foregroundColor: Colors.purple[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
          color: Colors.purple[900],
        ),
      ),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: Colors.purple[900],
      elevation: 0.0,
    ),
  );
}
