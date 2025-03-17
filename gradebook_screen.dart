import 'package:flutter/material.dart';

class GradeBookScreen extends StatelessWidget {
  const GradeBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gradebook"), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gradebook Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Subject - Grade - Marks Table
            Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: {
                0: FlexColumnWidth(2), // Subject
                1: FlexColumnWidth(1), // Grade
                2: FlexColumnWidth(1), // Marks
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  children: [
                    tableCell("Subject", isHeader: true),
                    tableCell("Grade", isHeader: true),
                    tableCell("Marks", isHeader: true),
                  ],
                ),
                tableRow("OOP", "A", "95"),
                tableRow("E-commerce", "B+", "88"),
                tableRow("DAA", "A-", "91"),
                tableRow("Web Development", "B", "85"),
                tableRow("Software Engineering", "A+", "98"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Table Row Generator
  TableRow tableRow(String subject, String grade, String marks) {
    return TableRow(
      children: [tableCell(subject), tableCell(grade), tableCell(marks)],
    );
  }

  // Table Cell Generator
  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
