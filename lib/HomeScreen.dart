import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartChef"),
        actions: <Widget>[
          Padding(
            child: Icon(Icons.portrait),
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
      ),
  
       body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/smart-chef21.appspot.com/o/Screenshot_20180509-231107.png?alt=media&token=f2a107a7-84cc-44a1-ae6b-cb175be2dcf2"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content content here */,
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final double cardSize;
  CardView(this.cardSize);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new SizedBox.fromSize(
      size: new Size(cardSize, cardSize),
    ));
  }
}