import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/subjectscreen.dart';
import 'package:mytutor/tutorscreen.dart';
import 'constants.dart';
import 'model/subjects.dart';
import 'model/user.dart';

class MyTutorMainScreen extends StatefulWidget {
  final User user;
  const MyTutorMainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MyTutorMainScreen> createState() => _MyTutorMainScreenState();
}

class _MyTutorMainScreenState extends State<MyTutorMainScreen> {
  late double screenHeight, screenWidth, ctrwidth, resWidth;
  late List<Widget> tabchildren;
  int currentIndex = 0;
  String maintitle = "Subjects";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      MyTutorSubjectScreen(
        user: widget.user,
      ),
      MyTutorTutorScreen(user: widget.user),
    ];
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }
    return Scaffold(
      body: tabchildren[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: "Subjects",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            label: "Tutors",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle_notifications,
            ),
            label: "Subscribe",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          )
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        maintitle = "Subjects";
      }
      if (currentIndex == 1) {
        maintitle = "Tutors";
      }
      if (currentIndex == 2) {
        maintitle = "Subscribe";
      }
      if (currentIndex == 3) {
        maintitle = "Favourite";
      }
      if (currentIndex == 4) {
        maintitle = "Profile";
      }
    });
  }
}
