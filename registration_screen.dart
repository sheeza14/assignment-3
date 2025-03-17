import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/services.dart'; // Import for input filtering

// Main Registration Screen Widget
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

// State class for RegistrationScreen
class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  String status = "Active"; // Default status
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  // Function to validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return emailRegex.hasMatch(email);
  }

  // Function to save user data in SharedPreferences
  Future<void> saveUserData() async {
    if (!_formKey.currentState!.validate()) return; // Stop if form is invalid

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userCount = prefs.getInt('user_count') ?? 0; // Get current user count

    // Save email, contact, and status with unique keys
    await prefs.setString('email_$userCount', emailController.text);
    await prefs.setString('contact_$userCount', contactController.text);
    await prefs.setString('status_$userCount', status);
    await prefs.setInt('user_count', userCount + 1); // Update user count

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Successfully Registered!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Clear fields after saving data
    emailController.clear();
    contactController.clear();
    setState(() {
      status = "Active"; // Reset status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"), // AppBar title
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0), // Padding around form elements
        child: Form(
          key: _formKey, // Assign form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Input Field with Validation
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(), // Add border around text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!isValidEmail(value)) {
                    return "Enter a valid Gmail address (@gmail.com)";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Contact Number Input Field (Allows only numbers)
              TextFormField(
                controller: contactController,
                keyboardType:
                    TextInputType.phone, // Set keyboard type for phone
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ], // ✅ Only allow numbers
                decoration: InputDecoration(
                  labelText: "Contact",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your contact number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Status Selection (Active/Inactive)
              Text("Status:", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  // Active Status Option
                  Radio(
                    value: "Active",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!; // Update status when selected
                      });
                    },
                  ),
                  Text("Active"),

                  // Inactive Status Option
                  Radio(
                    value: "Inactive",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!; // Update status when selected
                      });
                    },
                  ),
                  Text("Inactive"),
                ],
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: saveUserData, // Save data on button press
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
