import 'package:flutter/material.dart';

class Store extends ChangeNotifier {
  /* STATES */
  bool _isDark = false;
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    backgroundColor: Color(0xFFFFFFFF),
    textTheme: TextTheme(
      headline5: TextStyle(
        fontSize: 40.0,
      ),
      headline6: TextStyle(
        fontSize: 20.0,
        color: Color(0xFF545454),
      ),
      button: TextStyle(
        color: Color(0xFFD6D6D6),
        backgroundColor: Color(0xFF000000),
        fontSize: 24.0,
      ),
    ),
  );
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF000000),
    backgroundColor: Color(0xFF000000),
    textTheme: TextTheme(
      headline5: TextStyle(
        fontSize: 40.0,
        color: Color(0xFFFFFFFF),
      ),
      headline6: TextStyle(
        fontSize: 20.0,
        color: Color(0xFF8E8E8E),
      ),
      button: TextStyle(
        color: Color(0xFF303030),
        backgroundColor: Color(0xFFFFFFFF),
        fontSize: 24.0,
      ),
    ),
  );

  /* SETTERS */
  void toggleMode() {
    _isDark = !_isDark;
    notifyListeners();
  }

  /* GETTERS */
  bool isDark() => _isDark;
  ThemeData getTheme() => _isDark ? _darkTheme : _lightTheme;
  String getIllustration() =>
      _isDark ? "images/illustration-dark.png" : "images/illustration.png";
  String getIcon() => _isDark ? "images/icon.png" : "images/icon-dark.png";
}
