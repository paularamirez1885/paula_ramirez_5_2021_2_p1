import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Floating Action Button Label'),
        ),
        body: ListView(
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
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

  void _list() {
    
  }
}
