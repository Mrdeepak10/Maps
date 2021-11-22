import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{MarkerId('Singapore'):Marker(
    markerId: MarkerId('Singapore'),
    position: LatLng(22.800, 75.908),
    infoWindow: InfoWindow(title: 'Singapore', snippet: 'Township'),
    onTap: () {
      //_onMarkerTapped(markerId);
      print('Marker Tapped');
    },
    onDragEnd: (LatLng position) {
      print('Drag Ended');
    }, )};

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target:  LatLng(22.800639, 75.908108),
    zoom: 25.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(22.754661, 75.895191),
      zoom: 14.151926040649414);



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        compassEnabled: true,
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _goToTheLake,
            tooltip: 'Vijay Nagar',
            child: Icon(Icons.directions_boat),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
