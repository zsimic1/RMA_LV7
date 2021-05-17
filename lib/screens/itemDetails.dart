import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:list_lv/database/moor_database.dart';

class itemDetails extends StatefulWidget {
  final Item item;

  itemDetails({Key key, @required this.item}) : super(key: key);

  @override
  _itemDetailsState createState() => _itemDetailsState();
}

class _itemDetailsState extends State<itemDetails> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: () {
          print('marker tapped');
        },
        position: LatLng(double.parse(widget.item.latitude),
            double.parse(widget.item.longitude)),
        infoWindow: InfoWindow(title: widget.item.name)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details list'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 4,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.item.latitude),
                    double.parse(widget.item.longitude)),
                zoom: 5),
            markers: Set.from(markers),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.item.name,
            style: TextStyle(fontSize: 25,),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Opacity(
            opacity: 0.5,
            child: Text(widget.item.description,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Opacity(
            opacity: 0.5,
            child: Text(widget.item.guid,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.item.url), fit: BoxFit.cover)),
          ),
        ),
      ]),
    );
  }
}
