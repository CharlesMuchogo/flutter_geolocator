// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String location = " ";

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    log(permission.name);

    if (permission.name == "denied") {
      LocationPermission permissionRequest =
          await Geolocator.requestPermission();
          log(permissionRequest.name); 
      if (permissionRequest.name == "denied") {
        return;
      }
      
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log(position.latitude.toString());
    setState(() {
      location =
          " latitude: ${position.latitude.toString()}, longitude: ${position.longitude.toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Geolocator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(height: 20),
            location == ""
                ? Text(
                    "Get User Location",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                : Text(
                    location,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getLocation();
              },
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
