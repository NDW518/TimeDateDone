import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(57, 142, 172, 1),
      title: Text('TimeDateDone Reminders'),
    ),

    body: Center(child: Text('Reminders', style: TextStyle(fontSize: 60))) 
    );
}