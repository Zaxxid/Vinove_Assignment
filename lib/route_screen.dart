import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Member.dart';

class RouteScreen extends StatelessWidget {
  final Member member;

  const RouteScreen(this.member, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.indigo,
        title: const Text(
          'SEE ROUTE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
                    Text("${member.name} (${member.id})",
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
          const Divider(thickness: 1,height: 1,),
          // Start and Stop Location Row
          const Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 20,
                ),
                Text('2715 Ash Dr, SD Stop: 1901 Thornridge Cir, HI' , style: TextStyle( color: Colors.black45, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          // Distance and Duration Row
          const Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ),
                Text('1901 Thornridge Cir, Shiloh, Hawai 81063', style: TextStyle( color: Colors.black45,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          const Divider(thickness: 1,height: 2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text('Total Kms', style: TextStyle( fontSize: 14, color: Colors.grey),),
                    Text('45.5 Kms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                  ],
                ),
              ),

              Container(
                height: 20,
                width: 1,
                color: Colors.grey,
              ),
              const Column(
                children: [
                  Text('Total Duration', style: TextStyle( fontSize: 14, color: Colors.grey),),
                  Text('01 Hr 45 Min', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                ],
              ),
            ],
          ),
          // Google Map showing the route
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 14,
              ),
              polylines: {
                const Polyline(
                  polylineId: PolylineId('route'),
                  points: [
                    LatLng(37.7749, -122.4194), // Start Location
                    LatLng(37.8049, -122.4294), // End Location
                  ],
                  color: Colors.blue,
                  width: 5,
                ),
              },
              markers: {
                const Marker(
                  markerId: MarkerId('start_location'),
                  position: LatLng(37.7749, -122.4194),
                  infoWindow: InfoWindow(title: 'Start at 08:15 am'),
                ),
                const Marker(
                  markerId: MarkerId('stop_location'),
                  position: LatLng(37.8049, -122.4294),
                  infoWindow: InfoWindow(title: 'Stop at 10:00 am'),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}