import 'dart:async';

import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MarkerScreen extends StatefulWidget {
  const MarkerScreen({super.key});

  @override
  State<MarkerScreen> createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
   Completer<GoogleMapController> _controller = Completer();
   Uint8List? markerImage;

   List<String> images = ['assets/delivery-manw.png','assets/delivery-man.png','assets/sport-car.png'];

   final List<Marker> _marker = <Marker>[];
   final List<LatLng> _latlng = <LatLng>[
   const LatLng(27.6951, 84.2648),const LatLng(28.6951, 84.2648),const LatLng(29.6951, 84.2648)];


   static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(27.6951, 84.2648),
    zoom: 14,
  );
  Future<Uint8List> getBytesFromAssets(String path, int width) async{
   ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight:width);
  ui.FrameInfo fi =await codec.getNextFrame();
  return( await fi.image.toByteData(format:ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData() async{
    for(int i=0; i< images.length; i++){
      final Uint8List markerIcon = await  getBytesFromAssets(images[i], 100);
      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
        position: _latlng[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: 'this is title marker:'+i.toString()
        )
        ),
        
      );
      setState(() {
        
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: GoogleMap(initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        }),
      ),

    );
  }
}