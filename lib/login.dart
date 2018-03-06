import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

//This class only creates a widget for the Login , immutable/unchangeable class
class LoginWidget extends StatefulWidget{
  LoginWidget({Key key}):super(key: key);
  @override
  _LoginWidgetState createState()=> new _LoginWidgetState(); //Create a login State
}

//State class for [LoginWidget] State , can change the state
class _LoginWidgetState extends State<LoginWidget>{
  var _session;
  var _loginFlag=false; //initially not logged in
  final TextEditingController _controller= new TextEditingController();
  final TextEditingController _passController= new TextEditingController();



  @override
  Widget build(BuildContext context){

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            hintText: 'Type your Email Address',
          ),
        ),
        new TextField(
          controller: _passController,
          decoration: new InputDecoration(
            hintText: 'Type your Password',
          ),
          obscureText: true,
        ),
        new RaisedButton(
          onPressed: (){
            Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Checking your Credentials')));
            //Call to API to validate the email and password
            _loggingIn();

          },
          child: new Text('Login'),
        ),
        new FlatButton(
          onPressed: (){
            showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text('New User Registration'),
                content: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _controller,
                      decoration: new InputDecoration(
                        hintText: 'Your Email Address'
                      ),
                    ),
                    new TextField(
                      controller: _passController,
                      decoration: new InputDecoration(
                          hintText: 'Your New Password'

                      ),
                      obscureText: true,
                    ),

                  ],
                ),
              ),
            );
          },
          child: new Text('SignUp'),
        ),
      ],
    );
  }
  _loggingIn() async{
    //Starting a Session
    _startSession();
    //if new session is created, then show mapView

    //Navigator.of(context).pushNamed('/mapView');

    //else show login error snackbar
  }
  _startSession() async{
    var uri= new Uri.http('demo.traccar.org', '/api/server') ;
    var result;

    try{

      var response= await http.post(Uri.encodeFull('http://demo5.traccar.org/api/session?email='+_controller.text+'&password=assassin32'),headers: {"Content-Type":"application/x-www-form-urlencoded"});

      var data=JSON.decode(response.body);
      result=data;
    } catch (exception) {
      result = 'Failed getting Authorization address'+exception.toString();
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Email or password is wrong')));
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _session = result;
      if(result['id']!=null){
        _loginFlag=true;
        Navigator.of(context).pushNamed('/mapView');
      }
      else{
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Email or password is wrong')));
      }
    });

    print(_session);


  }
}