import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//This class only creates a widget for the Login , immutable/unchangeable class
class MapWidget extends StatefulWidget{
  MapWidget({Key key}):super(key: key);
  @override
  _MapWidgetState createState()=> new _MapWidgetState(); //Create a login State
}

//State class for [LoginWidget] State , can change the state
class _MapWidgetState extends State<MapWidget>{
  var _currentLocation = <String, double>{};
  var _positions;
  @override
  Widget build(BuildContext context) {
    //_getCurrentLocation();
    //_getDevicesPosition();
    print(_currentLocation);
    return new FlutterMap(
      options: new MapOptions(
        //map screen view centering
        center: new LatLng(23.730,90.419),
        zoom: 14.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            //Assess token from mapbox
            'accessToken': 'pk.eyJ1IjoiYm1hYmlyMTciLCJhIjoiY2plYTdodXd3MHo3ZDJxbzFvdHdhMXJxNyJ9.feAFXRCAG_1q1onz3NC5nw',
            'id': 'mapbox.streets',
          },
        ),

        //Make new Marker to show the position of devices
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(23.730099, 90.419609),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
  /*
  _getDevicesPosition() async{
    var result;

    try{
      var response= await http.get(Uri.encodeFull('http://demo.traccar.org/api/positions'),headers: {"Accept":"application/json"} );
      var data=JSON.decode(response.body);
      result=data;
    } catch (exception) {
      result = 'Failed getting device positions'+exception.toString();
      showDialog(context: context, child: new AlertDialog(title:  new Text(result.toString())));
    }
    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;
    setState(() {
      _positions = result;
      if(result[0]['id']!=null){
        showDialog(context: context, child: new AlertDialog(title:  new Text(result.toString())));

      }
      else{
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Unable to connect with server')));
      }
    });

    print(_positions);


  }
  */
}