import 'package:flutter/material.dart';
import 'package:rickandmorty/components/loader_component.dart';
import 'package:rickandmorty/models/result.dart';

class DetailScreen extends StatefulWidget {

  final Results person;

  DetailScreen({required this.person});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Results _person;
  bool _showLoader = true;
  late ScrollController _controller;


  @override
  void initState() {
    super.initState();
    _person = widget.person;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);//the listener for up and down. 
 super.initState();
 _showLoader = false;
  }

  _scrollListener() {
  if (_controller.offset >= _controller.position.maxScrollExtent &&
     !_controller.position.outOfRange) {
   setState(() {//you can do anything here
   });
 }
 if (_controller.offset <= _controller.position.minScrollExtent &&
    !_controller.position.outOfRange) {
   setState(() {//you can do anything here
    });
  }
}

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Center(child: Text(_person.name)),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _showData(),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('EPISODIOS', style: TextStyle(fontSize: 30)),
                  ),
                  _listEpisode(),
              ],),
              ),
              _showLoader ? LoaderComponent(text: 'Por favor espere...',) : Container(),
          ],
        ),
      ),
      );
  }

  Widget _listEpisode() {
    return ListView(
      shrinkWrap: true,
        controller: _controller,
        children: _person.episode.map((e) {
          return TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: e,
                  ),
                );
        }).toList(),
      );
  }

  _showData() {
    return Container(
      child: Column(
              children: <Widget>[
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status: ${_person.status}',
                  ),
                ),
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Species: ${_person.species}',
                  ),
                ),
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gender: ${_person.gender}',
                  ),
                ),
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Origin: ${_person.origin.name}',
                  ),
                ),
                TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location: ${_person.location.name}',
                  ),
                ),
                ClipOval(
                    child: Image(
                  image: NetworkImage(_person.image),
                  height: 200,
                  width: 200,
                )
                ), 
          ],
        ),
      );    
  }
  
}