import 'package:flutter/material.dart';
import 'package:flutter_assignment_04/goal_app.dart';

void main() {
  runApp(const MyProfile());
}

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyProfilePage',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GoalApp());
  }
}