import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFormPage extends StatefulWidget {
  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String selectedStatus = 'Active';

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('contact', contactController.text);
    await prefs.setString('status', selectedStatus);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact'),
              keyboardType: TextInputType.phone,
            ),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items:
                  ['Active', 'Inactive'].map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveData, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
