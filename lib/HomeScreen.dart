import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animCtrl;
  Animation<double> animation;

  AnimationController animCtrl2;
  Animation<double> animation2;

  bool showFirst = true;

  @override
  void initState() {
    super.initState();

    animCtrl = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    animation = new CurvedAnimation(parent: animCtrl, curve: Curves.easeOut);
    animation.addListener(() {
      this.setState(() {});
    });
    animation.addStatusListener((AnimationStatus status) {});

    animCtrl2 = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
    animation2 = new CurvedAnimation(parent: animCtrl2, curve: Curves.easeOut);
    animation2.addListener(() {
      this.setState(() {});
    });
    animation2.addStatusListener((AnimationStatus status) {});
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartChef"),
        actions: <Widget>[
          Padding(
            child: Icon(Icons.search),
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
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