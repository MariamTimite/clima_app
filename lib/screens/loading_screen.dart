
import 'package:climaaapp/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    if (permission == LocationPermission.denied) {
      
      return Future.error(
          'Location permissions are denied');
    }
  }

  
  
  return await Geolocator.getCurrentPosition();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
       var response =  await _determinePosition();
       Navigator.push(context, MaterialPageRoute(builder: (fer) => LocationScreen(position: response,)));
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
