import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'myprofile.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender = "Male"; // Default Gender
  File? _image;
  bool _obscurePassword = true;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('gender', gender);
      prefs.setString('address', addressController.text);
      if (_image != null) {
        prefs.setString('profile_image', _image!.path);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup Successful!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup"), backgroundColor: Colors.blue),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3, // Responsive Width
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email Field with Validation
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                      ).hasMatch(value)) {
                        return "Enter a valid Gmail address (e.g. user@gmail.com)";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Password Field with Strong Validation
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      } else if (!RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$',
                      ).hasMatch(value)) {
                        return "Must be 5+ chars, 1 Upper, 1 Lower, 1 Number, 1 Special";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Address Field with Validation
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address is required";
                      } else if (value.length < 10) {
                        return "Address must be at least 10 characters long";
                      } else if (value.split(" ").length < 5) {
                        return "Address must contain at least 5 words";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Gender Selection
                  Text("Gender:", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio(
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text("Male"),
                      Radio(
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text("Female"),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Profile Picture Upload
                  _image != null
                      ? Image.file(_image!, height: 100, width: 100)
                      : Text("No image selected"),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text("Pick Profile Picture"),
                  ),
                  SizedBox(height: 20),

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Signup",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
