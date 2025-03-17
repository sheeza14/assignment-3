import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  double result = 0;
  String selectedOperation = '';

  void calculate(String operation) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      selectedOperation = operation;
      if (operation == '+') {
        result = num1 + num2;
      } else if (operation == '-') {
        result = num1 - num2;
      } else if (operation == '*') {
        result = num1 * num2;
      } else if (operation == '/') {
        result = num2 != 0 ? num1 / num2 : 0;
      }
    });
  }

  void submitResult() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Result of $selectedOperation operation: $result"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator"), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter first number"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter second number"),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: Text("+"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: Text("-"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: Text("*"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: Text("/"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Result: $result",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitResult,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
