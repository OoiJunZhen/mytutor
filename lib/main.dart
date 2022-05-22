import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytutor/loginscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTutor',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyTutorSplashScreen(title: 'MyTutor'),
    );
  }
}

class MyTutorSplashScreen extends StatefulWidget {
  const MyTutorSplashScreen({Key? key, required String title})
      : super(key: key);

  @override
  State<MyTutorSplashScreen> createState() => _MyTutorSplashScreenState();
}

class _MyTutorSplashScreenState extends State<MyTutorSplashScreen> {
  late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => const MyTutorLoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset('assets/images/MyTutor.jpg'),
              ),
              const Text(
                "MyTutor",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CircularProgressIndicator(),
              const Text("Version 1.0",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
