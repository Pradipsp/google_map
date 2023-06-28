import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(27.6951, 84.2648),
    zoom: 14,
  );
  final Set<Marker> _markers ={};
  final Set<Polyline> _polyline = {};
  
  List<LatLng> latlng =[
    const LatLng(27.6951, 84.2648),
    const LatLng(27.667020, 84.259234),
    const LatLng(27.6951, 84.2648),
    const LatLng(27.669386, 84.268354),
    
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<latlng.length;i++){
      _markers.add(
                  Marker(
                    markerId: MarkerId(i.toString()),
        position: latlng[i],
          infoWindow: InfoWindow(
          title: 'this is title marker',
          snippet: '5 star rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        ),
        );
        setState(() {
          
        });
         _polyline.add(
      Polyline(polylineId: PolylineId('1'),
      points: latlng),
    );
      
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('polyline'),
      ),

      body:  GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
          onMapCreated:(GoogleMapController controller){
            _controller.complete(controller);
          },
          polylines: _polyline,
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: false,
                             
           ),

    );
  }
}