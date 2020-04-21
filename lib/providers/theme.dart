import 'dart:async';

import 'package:flutter/material.dart';

class ThemeBloc {
  final _themeStreamController = StreamController<bool>();
  
  get changeTheTheme => _themeStreamController.sink.add;
  get darkThemeIsEnabled => _themeStreamController.stream;
}
ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue[800],
  //primarySwatch: Colors.grey[300],
  accentColor: Color.fromARGB(255,0, 77, 128),//Color.fromARGB(255,153, 0, 0),//153/128
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  cardColor: Colors.grey[200],
  secondaryHeaderColor: Colors.grey[300],
);

ThemeData darkl = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[400],
  //primarySwatch: Colors.grey[800],
  accentColor: Colors.orange[800],
  scaffoldBackgroundColor: Colors.grey[850],
  backgroundColor: Colors.grey[800],
  primaryColorLight: Colors.white70,
  primaryColorDark: Colors.white70,
  cardColor: Colors.grey[800],
  secondaryHeaderColor: Colors.grey[700],
);