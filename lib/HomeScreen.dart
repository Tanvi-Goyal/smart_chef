import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

String _name, _email, _photoUrl;
_fetchDetails() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  _name = user.displayName;
  _email = user.email;
  _photoUrl = user.photoUrl;
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.black,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  /// Defaults to `Colors.black`.
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 1.5;
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
  _HomeScreenState createState() {
    _fetchDetails();
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
var _scaffoldKey = new GlobalKey<ScaffoldState>();
final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final _kArrowColor = Colors.black.withOpacity(0.8);
  final List<Widget> _pages = <Widget>[
    Image.network('https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true'),
    Image.network('https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true'),
    Image.network('https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true'),


    // new ConstrainedBox(
    //   constraints: const BoxConstraints.expand(),
    //   child:new Card(
    //     child: Container(
    //       color: Colors.red,
          
    //     ),
    //   )
    // ),
    // new ConstrainedBox(
    //   constraints: const BoxConstraints.expand(),
    //   child: new Card(
    //     child: Container(
    //       color: Colors.blue,
          
    //     ),
    //   )
    // ),
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
            padding: const EdgeInsets.only(right: 10.0 , top: 10.0 , bottom: 10.0),
          )
        ],
      ),
  
       body:Stack(
         fit: StackFit.expand,
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(color: Colors.blueAccent),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0 ,left: 10.0, right: 10.0,bottom: 5.0),
                  child: new IconTheme(
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
                
                color: Colors.grey[800].withOpacity(0.0),
                padding: const EdgeInsets.only(top: 10.0 , bottom: 10.0),
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
                ),
              ),
               Expanded(
                flex: 0,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 10.0 , bottom: 8.0),
                      child: Text(
                        "Hi",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    new Text(
                      "Bye",   
                    )
                  ],
                )
              ),
              Expanded(
                flex: 3,
                child: new GridView.count(
  primary: false,
  padding: const EdgeInsets.only(top: 10.0 ,left: 20.0 ,right: 20.0 ),
  crossAxisSpacing: 10.0,
  childAspectRatio: sqrt(0.8),
  crossAxisCount: 4,
  children: <Widget>[
   
    new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
    
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),

          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                  
                ),
                
              ),
              
            ),
            // new Divider(),
          ),

          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),

          // new Divider(),
          // new Divider(),
          // new Divider(),
          // new Divider(),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
          new FittedBox(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: new FittedBox(
                    child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left: 10.0 ,right: 10.0 ,bottom: 10.0)
                    ),
                    Text(
                      "Smart Chef" ,
                       style: TextStyle(
                         color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 10.0 , left: 10.0 ,right: 10.0)
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          ),
    
  ],
)
              ),
             
            ],
          ),
           
        ]
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
      accountName: new Text(_name),
      accountEmail: new Text(_email),
      currentAccountPicture: new GestureDetector(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(_photoUrl),
        ),
      ),
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage("")
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