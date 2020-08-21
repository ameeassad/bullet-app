import 'package:flutter/material.dart';
import 'package:bullet/bullets.dart';
import 'package:bullet/today.dart';
import 'package:bullet/calendar.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomSelectedIndex = 0;
  final DateTime todayDate= DateTime.now();
  List<Widget> pages;


  List<BottomNavigationBarItem> buildBottomNavBarItems(){
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.grain),
        title: Text('Bullets'),
      ),
      BottomNavigationBarItem(
        icon: Text(DateFormat('dd MMM').format(todayDate)),
        title: Text('Today'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event_note),
        title: Text('Calendar'),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    //todayDate = DateTime.now();
    pages = [
      BulletsPageView(),
      TodayPageView(todayDate: todayDate),
      CalendarPage(),
    ];
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      //pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[bottomSelectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => bottomTapped(index),
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
