import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UsersCurrentLocation extends StatefulWidget {
   const UsersCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UsersCurrentLocation> createState() => _UsersCurrentLocationState();
}

class _UsersCurrentLocationState extends State<UsersCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
    
   static const  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6951, 84.2648),
    zoom: 14,
  );

 
  final List<Marker> _markers = const<Marker>[
    Marker(
      markerId: MarkerId("1"),
    position: LatLng(27.6951, 84.2648),
    infoWindow: InfoWindow(
      title: "my current location"
    )
    ),
  ];


  loadData(){
    getUsersCurrentLocation().then((value) async {
              print("my current location");
              print("${value.latitude.toString()} ${value.longitude.toString()}");
             
              _markers.add( 
                Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: "My current location"
                  )
                  
                  
              ));
              CameraPosition cameraPosition=CameraPosition(
                zoom: 14,
                target: LatLng(value.latitude, value.longitude));
                final GoogleMapController controller = await _controller.future ;
                controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {
                  
                });



             });

  }
   
   Future <Position> getUsersCurrentLocation() async{

    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("error$error.toString()");
    });
    return await Geolocator.getCurrentPosition();

   }
  
  
  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap( 
        initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_markers),
           onMapCreated:(GoogleMapController controller){
            _controller.complete(controller);
          },
                             
           ),
           floatingActionButton: FloatingActionButton(
            onPressed: () {
             
           },
           child: const Icon(Icons.local_activity),
           ),
           
           
           );
    
  }
}