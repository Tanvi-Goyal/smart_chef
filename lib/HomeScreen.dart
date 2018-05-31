import 'package:flutter/material.dart';
import 'dart:math';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  /// Defaults to `Colors.white`.
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
var _scaffoldKey = new GlobalKey<ScaffoldState>();
final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final _kArrowColor = Colors.black.withOpacity(0.8);
  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(colors: Colors.green),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.horizontal, colors: Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: new AppDrawer(),
      appBar: AppBar(
        title: Text("SmartChef"),
        actions: <Widget>[
          Padding(
            child: RaisedButton(
            child: Icon(Icons.portrait),
            onPressed: (){
                _scaffoldKey.currentState.openEndDrawer();
            },
            ),
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
      ),
  
       body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.grey[800].withOpacity(0.5),
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
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

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
child: ListView(
  children: <Widget>[
    new UserAccountsDrawerHeader(
      accountName: new Text("Tanvi Goyal"),
      accountEmail: new Text("goyaltanvi94@gmail.com"),
      // currentAccountPicture: new GestureDetector(
      //   child: new CircleAvatar(
      //     backgroundImage: new NetworkImage("url"),
      //   ),
      // ),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/smart-chef21.appspot.com/o/Screenshot_20180509-231107.png?alt=media&token=f2a107a7-84cc-44a1-ae6b-cb175be2dcf2")
        )
      ),
    ),

    new ListTile(
      title: new Text("Item-1"),
      trailing: new Icon(Icons.portrait),
    ),
    new Divider(),
    new ListTile(
      title: new Text("Item-2"),
      trailing: new Icon(Icons.hearing),
    ),
    new Divider(),
    new ListTile(
      title: new Text("Logout"),
      trailing: new Icon(Icons.power_settings_new),
      onTap: ()=> Navigator.of(context).pop(),
    ),
  ],
),
    );
  }
}