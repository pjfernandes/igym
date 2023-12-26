import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import '../models/new_gymuser_form_data.dart';
import '../utils/routes.dart';
import 'package:http/http.dart' as http;

import '../services/auth_service.dart';
import '../screens/series_screen.dart';
import 'package:provider/provider.dart';

class NewGymUserScreen extends StatefulWidget {
  final User user;

  NewGymUserScreen({required this.user});

  @override
  State<NewGymUserScreen> createState() => _NewGymUserScreenState();
}

class _NewGymUserScreenState extends State<NewGymUserScreen> {
  final TextEditingController _heightController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _sexController = TextEditingController();

  final TextEditingController _objectiveController = TextEditingController();

  Future<void> _sendUserDataToAPI() async {
    // Send user data to your backend API
    // You'll need to replace the placeholder URL with your actual backend API endpoint
    final apiUrl = 'https://your-backend-api.com/userdata';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'uid': widget.user.uid,
        'height': _heightController.text,
        'weight': _weightController.text,
        'age': _ageController.text,
        'sex': _sexController.text,
        'objective': _objectiveController.text,
      },
    );

    if (response.statusCode == 200) {
      // Data sent successfully
      // You can handle the response or perform other actions here
    } else {
      // Handle error
      print('Failed to send user data. Error: ${response.reasonPhrase}');
    }
  }

  bool isLoading = false;

  Future<void> handleSubmit(NewGymUserFormData newGymUserFormData) async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);

      await AuthService.signup(
        widget.user,
        _heightController.text,
        _weightController.text,
        _ageController.text,
        _sexController.text,
      );

      await Navigator.of(context).popAndPushNamed(AppRoutes.SERIES);
    } catch (error) {
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }

    print(newGymUserFormData.email);
  }

  @override
  Widget build(BuildContext context) {
    final _newGymUserFormData =
        Provider.of<NewGymUserFormData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                height: 100,
              ),
            ),
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextFormField(
              controller: _sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            TextFormField(
              controller: _objectiveController,
              decoration:
                  InputDecoration(labelText: 'Objective in Bodybuilding'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                //await _sendUserDataToAPI();

                handleSubmit(_newGymUserFormData);

                // After sending data, navigate to the main screen to display exercises
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeriesScreen(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
