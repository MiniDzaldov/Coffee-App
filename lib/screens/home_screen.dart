import 'package:coffee_app/screens/cart_screen.dart';
import 'package:coffee_app/screens/intro_screen.dart';
import 'package:coffee_app/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import '../components/bottom_navbar.dart';
import '../const.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectIndex = 0;
  final List _pages =[
    ShopScreen(),
    CartScreen(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(onTabChange: navigateBottomBar),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: EdgeInsets.all(14),
              child: Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 80),
                Image.asset("lib/images/espresso.png", height: 160),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Divider(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 25),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ),
            )
          ],
        ),
      ),
      body: _pages[_selectIndex],
    );
  }
}


