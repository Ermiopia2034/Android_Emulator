import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart'; // for date formatting
import 'app_drawer.dart'; // Ensure this file exists in your project

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // This sets the theme to dark
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _timeString = "";
  String _dateString = "";

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now);
    final String formattedDate = _formatDate(now);
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEE, d MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    const String backgroundImage = 'assets/mainbg.jpg'; // Ensure this exists in your assets
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the children vertically
          children: <Widget>[
            Expanded(
              child: Center( // Center the clock vertically
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Start alignment from the top of the column
                  children: <Widget>[
                    SizedBox(height: 80), // Adjust this height to push the clock down from the top as needed
                    Text(
                      _timeString,
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _dateString,
                      style: TextStyle(fontSize: 20),
                    ),

                  ],
                ),

              ),
            ),
            Padding( // Pad the bottom button to make sure it's at the bottom
              padding: EdgeInsets.only(bottom: 50.0), // Space from bottom edge
              child: IconButton(
                icon: Icon(Icons.apps, size: 60.0, color: Colors.white), // Adjust icon size as needed
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => AppDrawer()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
