import 'package:flutter/material.dart';
import 'dart:async';
import 'MyNavigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
      super.initState();
      Timer(Duration(seconds: 3),()=> MyNavigator.goToIntro(context));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.greenAccent,
                      size: 50.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                ],
              ),
            )
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                  ),
                  Text(
                    "Welcome, on board",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 120.0),
                  ),
                  Container(
                    width: 350.0,
                    height: 45.0,
                    alignment: FractionalOffset.center,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: FlatButton(
                      onPressed: ()=> print("Google Tapped"),
                      // textColor: Colors.white,
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),

                  ///FACEBOOK LOGN
                  Padding(padding: EdgeInsets.only(top: 10.0),),
                  Container(
                    width: 350.0,
                    height: 45.0,
                    alignment: FractionalOffset.center,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: FlatButton(
                      onPressed: ()=> print("Facebook Tapped"),
                      child: Text(
                        "Sign in with Facebook",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
        )
        ],
      ),
    );
  }
}

