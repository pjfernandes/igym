import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'services/auth_service.dart';
import 'utils/routes.dart';
import 'models/new_gymuser_form_data.dart';
import 'screens/signup_or_app_screen.dart';
import '../screens/series_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewGymUserFormData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iGym',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LoginPage(),
        routes: {
          //AppRoutes.HOME: (ctx) => LoginPage(),
          AppRoutes.SIGNUP_OR_APP: (ctx) => SignUpOrAppScreen(),
          AppRoutes.SERIES: (ctx) => SeriesScreen()
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;

  bool isLoading = false;

  //final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final newGymUserFormData =
        Provider.of<NewGymUserFormData>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'iGym',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                height: 300,
              ),
              isLoading == false
                  ? Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          print("OK");
                          await AuthService.login(_auth, _googleSignIn);
                          print("OK2");
                          newGymUserFormData.updateName(
                              _googleSignIn.currentUser?.displayName ?? '');
                          newGymUserFormData.updateEmail(
                              _googleSignIn.currentUser?.email ?? '');
                          setState(() {
                            user = _auth.currentUser;
                          });

                          final gymUserExists =
                              await AuthService.gymUserExists(user);
                          await Navigator.of(context)
                              .pushNamed(AppRoutes.SIGNUP_OR_APP, arguments: {
                            'user': user,
                            'gymUserExists': gymUserExists,
                            'auth': _auth,
                            'google': _googleSignIn,
                          });

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/google_logo.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Sign in with Google/Gmail",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.yellow,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Loading",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 92, 225, 230),
                            ),
                          )
                        ],
                      ),
                    ),
              // TextButton(
              //   onPressed: () {
              //     AuthService.logout(_auth, _googleSignIn);
              //   },
              //   child: const Text(
              //     "Logout",
              //     style: TextStyle(fontSize: 18, color: Colors.green),
              //   ),
              // )
            ],
          ),
        ));
  }
}
