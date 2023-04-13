import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

void main() {
  runApp(const CalendarScreen());
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int currentIndex = 1;

  final screens = [
      Center(child: Text('Time Calculator', style: TextStyle(fontSize: 60))),
      Center(child: Text('Calendar', style: TextStyle(fontSize: 60))),    
      Center(child: Text('Reminders', style: TextStyle(fontSize: 60))),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(  // Bar Across the Top of the Screen
          backgroundColor: Color.fromRGBO(57, 142, 172, 1),
          title: const Text('THIS IS THE CALENDAR SCREEN'),
        ),
      
      body: screens[currentIndex],

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
