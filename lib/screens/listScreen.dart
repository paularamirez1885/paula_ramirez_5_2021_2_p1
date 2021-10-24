import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:rickandmorty/components/loader_component.dart';
import 'package:rickandmorty/helpers/constants.dart';
import 'package:rickandmorty/models/result.dart';
import 'package:rickandmorty/screens/detailScreen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _showLoader = false;
  bool _isFiltered = false;
  bool _showList = false;
  String _search = '';

  List<Results> _results = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Marck And Morty'),
        actions: <Widget>[
          _isFiltered
          ? IconButton(
              onPressed: _removeFilter, 
              icon: Icon(Icons.filter_none)
            )
          : IconButton(
              onPressed: _showFilter, 
              icon: Icon(Icons.filter_alt)
            )
        ],
        ),
        body: Stack(
          children: [
            _showList ? _getListView() : Container(),
            _showLoader ? LoaderComponent(text: 'Caragando...'): Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _list(),
        label: const Text('Listar'),
        icon: const Icon(Icons.list_alt_rounded),
        backgroundColor: Colors.pink,
      ),
      ),
    );
  }

  void _list() async {

     var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        _showLoader = false;
      });
      
       await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    

    setState(() {
      _showLoader = true;
    });

      var url = Uri.parse('${Constants.apiUrl}');
    var response = await http.get(url);

    if(response.statusCode >= 400){
      print(response);
      setState(() {
        _showLoader = false;
      });
      return;
    }

    var body = response.body;
    var decodedJson = jsonDecode(body);

    if(decodedJson != null){
        for (var i in decodedJson['results']) {
          _results.add(Results.fromJson(i));
        }
      }
      setState(() {
        _showLoader = false;
        _showList = true;
      });
  }

  Widget _getListView() {
    return Container(
      child: ListView(
        children: _results.map((e) {
          return ListTile(
            onTap: () => _goDetail(e),
            leading: Image.network(e.image),
              title: Text(e.name),
          );
        }).toList(),
      ),
    );
  }

  _goDetail(Results e) async {
    String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DetailScreen (
          person: e,
        )
      )
    );
    if (result == 'yes') {
      _list();
    }
  }

  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Filtrar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Escriba el criterio de búsqueda'),
              SizedBox(height: 10,),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Criterio de búsqueda...',
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) {
                  _search = value;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancelar')
            ),
            TextButton(
              onPressed: () => _filter(), 
              child: Text('Filtrar')
            ),
          ],
        );
      });
  }

   void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _list();
  }

  void _filter() {
    print(_search);
    if (_search.isEmpty) {
      return;
    }
    List<Results> filteredList = [];
    for (var result in _results) {
      if (result.name.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(result);
      }
    }

    
    setState(() {
      _results = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
}
}
