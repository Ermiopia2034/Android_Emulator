import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GPSApp extends StatefulWidget {
  @override
  _GPSAppState createState() => _GPSAppState();
}

class _GPSAppState extends State<GPSApp> {
  Location location = Location();
  LocationData? _currentLocation;
  bool _isFetchingLocation = false; // To track fetching status

  // Update for the background image
  final String backgroundImage = 'assets/gpsbg.jpg'; // Ensure this exists in your assets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              if (!_isFetchingLocation) {
                _getLocationAndShowDialog();
              }
            },
            child: Text('Get Your Current Location'),
          ),
        ),
      ),
    );
  }

  void _getLocationAndShowDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Fetching location..."),
              ],
            ),
          ),
        );
      },
    );

    await _fetchLocation(); // Fetch location
    Navigator.of(context).pop(); // Close the loading dialog

    _showLocationDialog(); // Show location dialog after fetching
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isFetchingLocation = true;
    });

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    setState(() {
      _isFetchingLocation = false;
    });
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Current Location"),
          content: SelectableText(
            'Latitude: ${_currentLocation?.latitude}\nLongitude: ${_currentLocation?.longitude}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Copy"),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: 'Latitude: ${_currentLocation?.latitude}, Longitude: ${_currentLocation?.longitude}'));
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
