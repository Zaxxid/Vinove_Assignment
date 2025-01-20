// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Member.dart';

class LiveLocationScreen extends StatefulWidget {
  final Member member;

  const LiveLocationScreen(this.member, {super.key});

  @override
  State<LiveLocationScreen> createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.7749, -122.4194),
      zoom: 14); // Updated to match San Francisco
  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'Patricia\'s Green Inn'),
    )
  ];

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print("Error$error");
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {Navigator.pop(context);},
        ),
        backgroundColor: const Color(0xFF42329E),
        title: const Text(
          'Track Live Location',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentLocation().then((value) async {
            // ignore: duplicate_ignore
            // ignore: avoid_print
            print("My current location is: ");
            print(value.latitude.toString() + value.longitude.toString());

            _markers.add(
                Marker(markerId: const MarkerId('2'),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: const InfoWindow(
                        title: "My Current Location"
                    ))
            );

            CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 14);

            final GoogleMapController controller = await _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });

          });
        },
        child: const Icon(Icons.location_on),
      ),
      body: Stack(
        children: [
          // Google Map showing the current location
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            compassEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers.toSet(),
            circles: {
              Circle(
                circleId: const CircleId('radiusCircle'),
                center: const LatLng(37.7749, -122.4194),
                radius: 500,
                // Radius in meters
                // ignore: deprecated_member_use
                fillColor: Colors.blue.withOpacity(0.2),
                strokeColor: Colors.blue,
                strokeWidth: 2,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          Positioned(
            top: 350,
            left: 170,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC4D4qC-OqCVv8jT4HjPuJ9izxULizCBRiPg&s"),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                  ),
                  child: const Text("5 min ago"),
                )
              ],
            ),
          ),

          Positioned(
            top: 0,
            child: Container(
              width: 400,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15, // You can adjust the size
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC4D4qC-OqCVv8jT4HjPuJ9izxULizCBRiPg&s'), // Replace with your image URL or asset
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${widget.member.name} (${widget.member.id})",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}

// Custom function to build each timeline tile
// ignore: unused_element
Widget _buildTimelineTile(String title, String subtitle, bool isFirst) {
  return ListTile(
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.circle, color: Color(0xFF42329E)
            , size: 10),
        if (!isFirst)
          Container(
              height: 40,
              width: 2,
              color: const Color(0xFF42329E)

          ),
      ],
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
  );
}
