import 'package:flutter/material.dart';
import 'message/message_page.dart';
import 'profile/profile_page.dart';
import 'home/home_page.dart';

class MainPage extends StatefulWidget {

  MainPage({String title});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentindex = 0;
  final List<Widget> _childrenWidget = [
    HomePage(),
    MessagePage(),
    ProfilePage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
      body: SafeArea(
        child: _childrenWidget[_currentindex],
      ),
    );
  }
  void _onTabTapped(int index){
    setState(() {
      _currentindex = index;
    });
  }
}
