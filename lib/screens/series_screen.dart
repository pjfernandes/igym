import 'package:flutter/material.dart';

class SeriesScreen extends StatelessWidget {
  // You'll need to implement the logic to fetch exercise series from ChatGPT API here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My exercises',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('Bodybuilding Exercise Series'),
      ),
    );
  }
}
