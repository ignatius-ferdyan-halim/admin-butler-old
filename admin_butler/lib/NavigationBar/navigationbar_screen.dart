import 'package:ebutler/Screens/addproduct_screen.dart';
import 'package:ebutler/Screens/adduser_screen.dart';
import 'package:ebutler/Screens/receiver_screen.dart';
import 'package:ebutler/Screens/status_screen.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    Receiver(),
    AddProduct(),
    // AddUser(),
    StatusScreen(),
  ];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text("Orders"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Add Product"),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_add),
          //   title: Text("Add User"),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            title: Text("Update Status"),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTap,
      ),
    );
  }
}
