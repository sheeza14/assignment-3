import 'package:flutter/material.dart';
import 'gradebook_screen.dart';
import 'calculator_screen.dart';
import 'registration_screen.dart';
import 'profile_screen.dart';
import 'login.dart'; // ✅ Login Screen Import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text('Baba Guru Nanak University'),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/vc_pic.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 40),
            Expanded(
              child: Text(
                "Baba Guru Nanak University (BGNU) is a Public sector university located in District Nankana Sahib, in the Punjab region of Pakistan...",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.school, color: Colors.blue, size: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Home Page'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue),
              title: Text('Gradebook'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GradeBookScreen()),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.calculate, color: Colors.blue),
              title: Text('Calculator'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalculatorScreen()),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.app_registration, color: Colors.blue),
              title: Text('Registration'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('View Profile'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.login, color: Colors.blue), // ✅ Login Icon
              title: Text('Login'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ), // ✅ Open Login Screen
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 34, 152, 207),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Baba Guru Nanak University",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
