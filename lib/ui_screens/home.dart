import 'package:flutter/material.dart';
import 'package:movies_app/ui_screens/SearchPage.dart';

import 'package:movies_app/ui_screens/home_tab.dart';

import 'package:movies_app/ui_screens/watchList_tab.dart';

import 'Search_tab.dart';
import 'browse_tab.dart';

class HomeScreen extends StatefulWidget {

   HomeScreen({super.key});
static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedTab=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[SelectedTab] ,
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: Color(0xff1A1A1A),
          elevation: 0,
        iconSize: 30,
        mouseCursor: MouseCursor.defer,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.yellow),
          selectedIconTheme: IconThemeData(color: Colors.yellow),
          selectedItemColor: Colors.yellow,
          currentIndex: SelectedTab,
          onTap: (index) {
            SelectedTab=index;
            setState(() {
            });
          },
          items:[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.open_in_browser_outlined),label: "Browse"),
        BottomNavigationBarItem(icon: Icon(Icons.watch_later),label: "Watch List"),
      ],
        type: BottomNavigationBarType.fixed,)
    );
  }

  List pages = [
HomeTab(),
    Searchpage(),
    BrowseTab(),
    WatchlistTab(),
  ];
}
