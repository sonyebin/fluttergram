import 'package:flutter/material.dart';

var theme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize:23),
        actionsIconTheme: IconThemeData(color: Colors.black, size: 35)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.black)),
);