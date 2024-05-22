import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LiveTracking extends StatefulWidget {
  @override
  _LiveTrackingState createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _startLiveTracking();
  }

  void _startLiveTracking() {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // Puedes ajustar la precisión aquí
      distanceFilter: 10, // Cambia esto según la precisión que necesites
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        setState(() {
          _currentPosition = position;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seguimiento en Vivo'),
      ),
      body: Center(
        child: _currentPosition == null
            ? Text('Esperando ubicación...')
            : Text(
                'Latitud: ${_currentPosition!.latitude}, Longitud: ${_currentPosition!.longitude}'),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: LiveTracking(),
    ));
