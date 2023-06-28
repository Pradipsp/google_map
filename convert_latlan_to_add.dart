import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLang extends StatefulWidget {
  const ConvertLatLang({super.key});

  @override
  State<ConvertLatLang> createState() => _ConvertLatLangState();
}

class _ConvertLatLangState extends State<ConvertLatLang> {
  String stAddress = "";
  String stAdd = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap: () async{
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(27.6951, 84.2648);
              setState(() {
               stAddress = "${locations.last.latitude.toString()}, ${locations.last.longitude.toString()}";
                stAdd = "${placemarks.reversed.last.country.toString()} , ${placemarks.reversed.last.locality.toString()} ,${placemarks.reversed.last.administrativeArea.toString()}"
                 ;
              });


            },
          
          
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Center(
                  child: Text("convert"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}