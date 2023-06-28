import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

     Completer<GoogleMapController> _controller = Completer();
    
   static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6951, 84.2648),
    zoom: 14,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = const[
    Marker(
      markerId: MarkerId("1"),
    position: LatLng(27.6951, 84.2648),
    infoWindow: InfoWindow(
      title: "my current location"
    )
    ),
    Marker(
      markerId: MarkerId("2"),
    position: LatLng(27.7084416503, 84.4076234999),
    infoWindow: InfoWindow(
      title: "LICT"
    )
    ),
    Marker(
      markerId: MarkerId("3"),
    position: LatLng(35.1952, 139.6568),
    infoWindow: InfoWindow(
      title: "Japan"
    )
    ),


  ];
  @override
    void initState() {
    super.initState();
    _marker.addAll(_list);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
           onMapCreated:(GoogleMapController controller){
            _controller.complete(controller);
          },
                             
           ),
      ),
    floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.location_disabled_outlined),
      onPressed: ()async{
        GoogleMapController controller= await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          const CameraPosition(
            target: LatLng(35.1952, 139.6568),
          zoom: 14),
          
         ) );
         setState(() {
           
         });

      },
     ) );
  }
}

 
    
  
