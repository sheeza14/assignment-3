import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'login.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String? email;
  String? address;
  String? gender;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? "No Email";
      address = prefs.getString('address') ?? "No Address";
      gender = prefs.getString('gender') ?? "Not Specified";
      profileImage = prefs.getString('profile_image');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile"), backgroundColor: Colors.blue),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Responsive Width
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              profileImage != null && File(profileImage!).existsSync()
                  ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(profileImage!)),
                  )
                  : Icon(Icons.account_circle, size: 100, color: Colors.grey),
              SizedBox(height: 10),
              Text("Email: $email", style: TextStyle(fontSize: 18)),
              Text("Address: $address", style: TextStyle(fontSize: 18)),
              Text("Gender: $gender", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              // Logout Button
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  "Logout",
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
