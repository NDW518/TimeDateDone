import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController resultOutput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  bool pastCalc = false;
  bool futureCalc = false;
  bool dayCalc = false;
  bool weekCalc = false;
  bool monthCalc = false;
  bool yearCalc = false;


  int _wasItwillItRadioValue = -1;
  int _timeScaleRadioValue = -1;

  // DateTime pickedDate = DateTime.now(); 

  String inputTimeAmount = '';
  int timeAmount = 0;

  void _handleRadioValueChange1(int? value) {
    setState(() {
      _wasItwillItRadioValue = value!;

      switch (_wasItwillItRadioValue) {
        case 0:
          pastCalc = true;
          futureCalc = false;
          break;
        case 1:
          futureCalc = true;
          pastCalc = false;
          break;
      }
    });
  }

  void _handleRadioValueChange2(int? value) {
    setState(() {
      _timeScaleRadioValue = value!;

      switch (_timeScaleRadioValue) {
        case 0:
          dayCalc = true;
          weekCalc = false;
          monthCalc = false;
          yearCalc = false;          
          break;
        case 1:
          dayCalc = false;
          weekCalc = true;
          monthCalc = false;
          yearCalc = false;       
          break;
        case 2:
          dayCalc = false;
          weekCalc = false;
          monthCalc = true;
          yearCalc = false;       
          break;
        case 3:
          dayCalc = false;
          weekCalc = false;
          monthCalc = false;
          yearCalc = true;       
          break;
      }
    });
  }

  DateTime calculateTime(functionInputDate){
    DateTime result_to_return = DateTime.now();

      if (pastCalc && dayCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').subtract(days: timeAmount).dateTime;
        result_to_return = result;
      }

      if (pastCalc && weekCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').subtract(weeks: timeAmount).dateTime;
        result_to_return = result;
      }

      if (pastCalc && monthCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').subtract(months: timeAmount).dateTime;
        result_to_return = result;
      }

      if (pastCalc && yearCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').subtract(years: timeAmount).dateTime;
        result_to_return = result;
      }

      if (futureCalc && dayCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').add(days: timeAmount).dateTime;
        result_to_return = result;
      }

      if (futureCalc && weekCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').add(weeks: timeAmount).dateTime;
        result_to_return = result;
      }

      if (futureCalc && monthCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').add(months: timeAmount).dateTime;
        result_to_return = result;
      }

      if (futureCalc && yearCalc){
        final result = Jiffy.parse(functionInputDate.toString(), pattern: 'MM-dd-yyyy').add(years: timeAmount).dateTime;
        result_to_return = result;
      }

      return result_to_return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            dividerTheme: const DividerThemeData(
          color: Colors.black,
          space: 30,
          thickness: 3,
          indent: 400,
          endIndent: 400,
        )),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(57, 142, 172, 1),
              title: const Text('TimeDateDone Time Calculator'),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('What day...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _wasItwillItRadioValue,
                        onChanged: _handleRadioValueChange1,
                      ),
                      const Text('Was it....',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                      Radio(
                        value: 1,
                        groupValue: _wasItwillItRadioValue,
                        onChanged: _handleRadioValueChange1,
                      ),
                      const Text('Will it be...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                    ],
                  ),
                  const Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            label: const Center(child: Text("Enter a Number")),
                            constraints: BoxConstraints(
                                minWidth: 90.0, maxWidth: 120.0)),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value){
                          setState(() {
                            inputTimeAmount = value;
                            timeAmount = int.parse(inputTimeAmount);
                          });
                        }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _timeScaleRadioValue,
                            onChanged: _handleRadioValueChange2,
                          ),
                          const Text('Days',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                          Radio(
                            value: 2,
                            groupValue: _timeScaleRadioValue,
                            onChanged: _handleRadioValueChange2,
                          ),
                          const Text('Months',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _timeScaleRadioValue,
                            onChanged: _handleRadioValueChange2,
                          ),
                          const Text('Weeks',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                          Radio(
                            value: 3,
                            groupValue: _timeScaleRadioValue,
                            onChanged: _handleRadioValueChange2,
                          ),
                          const Text('Years',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('From...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                  TextField(
                      controller: dateinput,
                      readOnly: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter Date",
                        constraints:
                            BoxConstraints(minWidth: 100.0, maxWidth: 120.0),
                      ),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            dateinput.text =
                                DateFormat('MM-dd-yyyy').format(pickedDate);
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                
                  Divider(),

                  ElevatedButton(
                    onPressed: (){
                      resultOutput.text = DateFormat('MM-dd-yyyy').format(calculateTime(dateinput.text));
                    },
                    child: const Text('Calculate Date'),
                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(57, 142, 172, 1))
                  ),

                  TextField(
                    controller: resultOutput,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      label: const Center(child: Text("It is/was")),
                      labelStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                      constraints: BoxConstraints(minWidth: 50.0, maxWidth: 100.0),
                    ),
                  )
                ],
              ),
            )));
  }
}
