import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import './pages/calculator_page.dart';
import './pages/calendar_page.dart';
import './pages/reminders_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  int currentIndex = 1;

  final screens = [
      CalculatorPage(),
      CalendarPage(),
      RemindersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       /* appBar: AppBar(  // Bar Across the Top of the Screen
          backgroundColor: Color.fromRGBO(57, 142, 172, 1),
          title: const Text('TimeDateDone'),
        ), */
      
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Color.fromRGBO(57, 142, 172, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        iconSize: 40,
        items: const [ 
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty),
            label: "Time Calculator"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Calendar"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Reminders"
          ),
        ],

        onTap: (index) => setState(() => currentIndex = index),

      ),
      ),
    );
  }
}
