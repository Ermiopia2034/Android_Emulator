import 'package:flutter/material.dart';
import 'mock_calculator.dart';
import 'text_message_screen.dart';
import 'gps_app.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for the background image
    const String backgroundImage = 'assets/appdbg.jpeg'; // Replace with your actual image path
    return Scaffold(
      appBar: AppBar(
        title: Text('App Drawer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.0,
          ),
          itemCount: 30, // Updated item count for more icons
          itemBuilder: (context, index) {
            Widget child;
            String label;

            // Adjusting margins
            EdgeInsets margin = const EdgeInsets.all(8); // Default margin for all icons
            if (index == 0) { // Apply a specific margin to the calculator icon
              margin = const EdgeInsets.fromLTRB(8, 8, 8, 20); // Increase bottom margin for calculator
            }

            switch (index) {
              case 0:
                child = Icon(Icons.calculate, size: 50, color: Colors.white);
                label = 'Calculator';
                break;
              case 1:
                child = Icon(Icons.message, size: 50, color: Colors.white);
                label = 'Text App';
                break;
              case 2: // GPS App icon
                child = Icon(Icons.location_on, size: 50, color: Colors.white);
                label = 'GPS App';
                break;
              default:
              // Dummy icons
                child = Icon(Icons.devices_other, size: 50, color: Colors.white);
                label = 'App $index';
            }

            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MockCalculator()));
                } else if (index == 1) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => TextMessageScreen()));
                } else if (index == 2) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => GPSApp())); // Make sure to create the GPS app file
                }
                // Implement other app navigations if necessary
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // Center the icons vertically
                children: <Widget>[
                  Expanded(child: Center(child: child)), // Center the icon horizontally
                  SizedBox(height: 8), // Add space between the icon and the text
                  Text(label, style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
