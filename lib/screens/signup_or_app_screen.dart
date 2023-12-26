import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/gymuser.dart';
//import 'loading_screen.dart';
import 'new_gymuser_screen.dart';
import 'series_screen.dart';
import '../services/auth_service.dart';
import '../screens/series_screen.dart';

class SignUpOrAppScreen extends StatelessWidget {
  const SignUpOrAppScreen({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final gymUserExists = arguments['gymUserExists'] as bool;
    final user = arguments['user'] as User;

    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 126, 217, 87),
            ),
          );
        } else {
          return StreamBuilder<GymUser?>(
            stream: AuthService().gymuserChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(255, 126, 217, 87),
                  ),
                );
              } else {
                return snapshot.hasData && !gymUserExists
                    ? NewGymUserScreen(user: user)
                    : SeriesScreen();
              }
            },
          );
        }
      },
    );
  }
}
