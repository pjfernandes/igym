import 'package:flutter/material.dart';

class NewGymUserFormData with ChangeNotifier {
  String name = '';
  String email = '';
  String height = '';
  String weight = '';
  String age = '';
  String sex = '';

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }
}
