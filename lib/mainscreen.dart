import 'package:flutter/material.dart';

class MyTutorMainScreen extends StatefulWidget {
  const MyTutorMainScreen({Key? key}) : super(key: key);

  @override
  State<MyTutorMainScreen> createState() => _MyTutorMainScreenState();
}

class _MyTutorMainScreenState extends State<MyTutorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('Welcome to "My Tutor"',
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
