import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyNavigator.dart';
import 'Walkthrough.dart';
import 'SplashScreen.dart';

String _name;
class IntroScreen extends StatefulWidget {
  final String name;
  IntroScreen({Key key, this.name}) : super (key: key);
  @override
  IntroScreenState createState() { 
    _name = name;
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
                  title: "Welcome, $_name",
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