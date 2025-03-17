import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> users = []; // List to store user data

  @override
  void initState() {
    super.initState();
    loadUserData(); // Load data on screen open
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userCount = prefs.getInt('user_count') ?? 0;

    List<Map<String, String>> loadedUsers = [];

    for (int i = 0; i < userCount; i++) {
      String? email = prefs.getString('email_$i');
      String? contact = prefs.getString('contact_$i');
      String? status = prefs.getString('status_$i');

      if (email != null && contact != null && status != null) {
        loadedUsers.add({"email": email, "contact": contact, "status": status});
      }
    }

    setState(() {
      users = loadedUsers;
    });
  }

  // Delete user from SharedPreferences
  Future<void> deleteUser(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userCount = prefs.getInt('user_count') ?? 0;

    // Remove selected user
    for (int i = index; i < userCount - 1; i++) {
      await prefs.setString(
        'email_$i',
        prefs.getString('email_${i + 1}') ?? "",
      );
      await prefs.setString(
        'contact_$i',
        prefs.getString('contact_${i + 1}') ?? "",
      );
      await prefs.setString(
        'status_$i',
        prefs.getString('status_${i + 1}') ?? "",
      );
    }

    await prefs.remove('email_${userCount - 1}');
    await prefs.remove('contact_${userCount - 1}');
    await prefs.remove('status_${userCount - 1}');
    await prefs.setInt('user_count', userCount - 1);

    loadUserData(); // Refresh list after deletion

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("User deleted successfully!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profiles"),
        backgroundColor: Colors.blue,
      ),
      body:
          users.isEmpty
              ? Center(
                child: Text(
                  "No users registered yet!",
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color:
                        users[index]["status"] == "Active"
                            ? Colors.lightGreen[100]
                            : Colors.red[100],
                    child: ListTile(
                      title: Text(users[index]["email"] ?? ""),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contact: ${users[index]["contact"]}"),
                          Text("Status: ${users[index]["status"]}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed:
                            () => deleteUser(index), // Delete user on tap
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
