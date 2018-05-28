import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'HomeScreen.dart';
import 'IntroScreen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
};

void main() => runApp(new MaterialApp(
  theme:
        ThemeData(primaryColor: Colors.red, accentColor: Colors.yellow),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes,
));
