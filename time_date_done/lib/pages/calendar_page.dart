import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final eventTitleController = TextEditingController();
  final eventDescriptionController = TextEditingController();

  Map<String, List> mySelectedEvents = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: eventTitleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: eventDescriptionController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (eventTitleController.text.isEmpty &&
                  eventDescriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDay!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDay!)]
                        ?.add({
                      "eventTitle": eventTitleController.text,
                      "eventDescp": eventDescriptionController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDay!)] = [
                      {
                        "eventTitle": eventTitleController.text,
                        "eventDescp": eventDescriptionController.text,
                      }
                    ];
                  }
                });

                eventTitleController.clear();
                eventDescriptionController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(57, 142, 172, 1),
        title: Text('TimeDateDone Calendar'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 392,
            width: 400,
            child: Center(
              child: TableCalendar(
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                availableGestures: AvailableGestures.all,
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                eventLoader: _listOfDayEvents,
              ),
            ),
          ),
          Divider(
              height: 30,
              indent: 600,
              endIndent: 600,
              color: Color.fromRGBO(57, 142, 172, 1)),
          const Text('Events for this day',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17.0)),
          Divider(height: 10, color: Colors.white),
          SizedBox(
            height: 200,
            width: 400,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                ..._listOfDayEvents(_selectedDay!)
                    .map(
                      (myEvents) => ListTile(
                        leading: const Icon(
                          Icons.done,
                          color: Color.fromRGBO(57, 142, 172, 1),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child:
                              Text('Event Title:   ${myEvents['eventTitle']}'),
                        ),
                        subtitle:
                            Text('Description:   ${myEvents['eventDescp']}'),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
        backgroundColor: Color.fromRGBO(57, 142, 172, 1),
      ),
    ));
  }
}
