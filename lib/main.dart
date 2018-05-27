import 'package:flutter/material.dart';
import 'dart:async';

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


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Timer(Duration(seconds: 5),()=> MyNavigator.goToIntro(context));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.red),
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
                      "SmartChef" ,
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
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  )
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

class MyNavigator {
   static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }
}

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

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final imageIcon;
  final imagecolor;

  Walkthrough(
      {this.title,
      this.content,
      this.imageIcon,
      this.imagecolor = Colors.redAccent});

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}

class WalkthroughState extends State<Walkthrough>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: -250.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animation.addListener(() => setState(() {}));

    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        animationDuration: Duration(milliseconds: 500),
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Transform(
              transform:
                  new Matrix4.translationValues(animation.value, 0.0, 0.0),
              child: new Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            new Transform(
              transform:
                  new Matrix4.translationValues(animation.value, 0.0, 0.0),
              child: new Text(widget.content,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.black)),
            ),
            new Icon(
              widget.imageIcon,
              size: 100.0,
              color: widget.imagecolor,
            )
          ],
        ),
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == 3) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                Walkthrough(
                  title: "WELCOME",
                  content: "A smart chef app",
                  imageIcon: Icons.mobile_screen_share,
                ),
                Walkthrough(
                  title: "DISCOVER PRODUCT",
                  content: "Search Latest and Featured Product\n With Best Price",
                  imageIcon: Icons.search,
                ),
                Walkthrough(
                  title: "ADD TO CART",
                  content: "Add to Cart All Product You need\n And Checkout the Order",
                  imageIcon: Icons.shopping_cart,
                ),
                Walkthrough(
                  title: "VERIFY AND RECEIVE",
                  content: "We Will Verify Your Order\n Pay the bill and Receive the Product",
                  imageIcon: Icons.verified_user,
                ),
              ],
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(lastPage ? "" :"SKIP",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () =>
                      lastPage ? null : MyNavigator.goToHome(context),
                ),
                FlatButton(
                  child: Text(lastPage ? "GOT IT" : "NEXT",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? MyNavigator.goToHome(context)
                      : controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}