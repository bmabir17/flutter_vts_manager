import 'package:flutter/material.dart';
import 'login.dart';
import 'mapView.dart';
void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //final wordPair = new WordPair.random();
    return new MaterialApp(
      title:'MononAI Tracker',
      home: new Scaffold( //becomes the route named '/'
        appBar: new AppBar(
          title: new Text('MononAI Tracker'),
        ),
        body: new Center(
          //child: new Text('Hello AI'),
          child: new LoginWidget(),
        ),
      ),
      routes: <String,WidgetBuilder>{

        '/mapView': (BuildContext context) => new MapWidget(),

      },
    );
  }
}

