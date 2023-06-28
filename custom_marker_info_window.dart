
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:custom_info_window/custom_info_window.dart';




class CustomInfoWindowExample extends StatefulWidget {
  @override
  _CustomInfoWindowExampleState createState() =>
      _CustomInfoWindowExampleState();
}

class _CustomInfoWindowExampleState extends State<CustomInfoWindowExample> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
       final List<Marker> _marker = <Marker>[];
   final List<LatLng> _latlng = <LatLng>[
   const LatLng(27.6951, 84.2648),const LatLng(28.6951, 84.2648),const LatLng(29.6951, 84.2648)];
   @override
     void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData(){

    for(int i=0;i<_latlng.length;i++){
    _marker.add(
    Marker(markerId: MarkerId(i.toString()),
    icon:BitmapDescriptor.defaultMarker,
    position: _latlng[i],
    onTap: () {
      
    _customInfoWindowController.addInfoWindow!(
      Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width:300,
              height: 100,
              decoration:   const BoxDecoration(
                // image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fimages%2Ffood%2Fcake&psig=AOvVaw2fRqwjXwepMp5zdD_HJua-&ust=1685460517251000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCOCT3e3rmv8CFQAAAAAdAAAAABAE',
                // fit:BoxFit.fitWidth,
                // filterQuality:FilterQuality.high),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.red,
               ),
            )
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
      //   child: Row(
      //     children: [
      //       const SizedBox(
      //         width: 100,
      //         child: Text(
      //           'cake',
      //           maxLines: 1,
      //           overflow: TextOverflow.fade,
      //           softWrap: false,
      //         ),
      //       ),
      //       const Spacer(),
      //       Text('.3 mi.'),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: ,
      // ),
      _latlng[i]
    );
    },
    ),
    );
    setState(() {
      
    });
  }
  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom info window '),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(27.6951, 84.2648),
              zoom: 15,
              ),
              markers: Set<Marker>.of(_marker),
              onTap: (position){
                _customInfoWindowController.hideInfoWindow!();

              },
              onCameraMove: (position){
                _customInfoWindowController.onCameraMove!();
                },

              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController =controller;
              },
              ),
             
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 100,
                width:300,
                offset: 35,
                
              )
        ],
      ),
    );
   
      
                
                        
    
      
           
         
        
      
    
  }
}