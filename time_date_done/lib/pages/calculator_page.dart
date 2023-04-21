import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(57, 142, 172, 1),
      title: Text('TimeDateDone Time Calculator'),
    ),

    body: Center(child: Text('Calculator', style: TextStyle(fontSize: 60))) 
    );
}