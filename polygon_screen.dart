import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(27.6951, 84.2648),
    zoom: 14,
  );
  final Set<Marker> _markers ={};
  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points =[
    const LatLng(27.6951, 84.2648),
    const LatLng(27.667020, 84.259234),
    const LatLng(27.669386, 84.268354),
    const LatLng(27.6951, 84.2648),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(polygonId:PolygonId('1'),points: points,
      fillColor: Colors.red.withOpacity(0.3),
      geodesic: true,
      strokeWidth: 4,
      strokeColor: Colors.deepOrange,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title: const Text('polygon'),

      ),
      body:  GoogleMap(
        mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: false,
         polygons: _polygon,
           onMapCreated:(GoogleMapController controller){
            _controller.complete(controller);
          },
                             
           ),
      );
    
  }
}