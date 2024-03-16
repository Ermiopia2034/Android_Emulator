import 'package:flutter/material.dart';
import 'mock_calculator.dart';
import 'text_message_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Drawer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 1.0,
        ),
        itemCount: 2, // Adjust based on the number of apps
        itemBuilder: (context, index) {
          Widget child;
          String label;

          switch (index) {
            case 0:
              child = Icon(Icons.calculate, size: 50);
              label = 'Calculator';
              break;
            case 1:
              child = Icon(Icons.message, size: 50);
              label = 'Text App';
              break;
            default:
              child = Icon(Icons.apps, size: 50);
              label = 'App $index';
          }

          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MockCalculator()));
              } else if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => TextMessageScreen()));
              }
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
    );
  }
}
