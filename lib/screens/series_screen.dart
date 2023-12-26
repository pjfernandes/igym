import 'package:flutter/material.dart';

class SeriesScreen extends StatelessWidget {
  // You'll need to implement the logic to fetch exercise series from ChatGPT API here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iGym'),
      ),
      body: Center(
        child: Text('Bodybuilding Exercise Series'),
      ),
    );
  }
}
