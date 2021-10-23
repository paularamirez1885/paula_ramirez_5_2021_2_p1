import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/listScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty',
      home: ListScreen(),
    );
  }
}