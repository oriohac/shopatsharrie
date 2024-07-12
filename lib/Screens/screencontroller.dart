import 'package:flutter/material.dart';
import 'package:shopatsharrie/Screens/home.dart';
import 'package:shopatsharrie/Screens/profile.dart';
import 'package:shopatsharrie/Screens/search.dart';
import 'package:shopatsharrie/Screens/wishlist.dart';

class Screencontroller extends StatefulWidget {
  const Screencontroller({super.key});

  @override
  State<Screencontroller> createState() => _ScreencontrollerState();
}

class _ScreencontrollerState extends State<Screencontroller> {
  //initiial screen of the BottomNavigation
  int selectedScreen = 0;
// function to update the screen according to what's selected in the BottomNavigation
  void currentScreen(int state) {
    setState(() {
      selectedScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    List screens = [
      Home(),
      Wishlist(),
      Profile(),
      Search(),
    ];
    return Scaffold(
      body: screens[selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedScreen,
        onTap: currentScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
