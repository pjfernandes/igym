import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/gymuser.dart';

class AuthService {
  static GymUser? _currentGymUser;

  static final _gymuserStream = Stream<GymUser?>.multi(
    (controller) async {
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final gymuser in authChanges) {
        _currentGymUser = gymuser == null ? null : toGymUser(gymuser);
        controller.add(_currentGymUser);
        _currentGymUser == null
            ? "DESLOGADO"
            : print("STREAM " + _currentGymUser!.email);
      }
    },
  );

  @override
  GymUser? get currentGymUser {
    return _currentGymUser;
  }

  @override
  Stream<GymUser?> get gymuserChanges {
    return _gymuserStream;
  }

  static login(FirebaseAuth auth, GoogleSignIn googleSignIn) async {
    print("FOI");
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential? userCredential =
        await auth.signInWithCredential(credential);

    User? user = userCredential.user;
    print(user!.displayName);
  }

  static Future<void> signup(
    User user,
    String height,
    String weight,
    String age,
    String sex,
  ) async {
    // final signup = await Firebase.initializeApp(
    //   name: 'userSignup',
    //   options: Firebase.app().options,
    // );

    //final auth = FirebaseAuth.instanceFor(app: signup);

    _currentGymUser = toGymUser(
      user,
      user.uid,
      user.email,
      user.displayName,
      height,
      weight,
      age,
      sex,
    );
    await saveGymUser(_currentGymUser!);
  }

  static Future<void> logout(FirebaseAuth auth, GoogleSignIn googleUser) async {
    await googleUser.signOut();
    await auth.signOut();
    print("deslogado");
  }

  static Future<void> saveGymUser(GymUser gymuser) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('gymusers').doc(gymuser.id);

    await docRef.set(
      {
        'id': gymuser.id,
        'email': gymuser.email,
        'name': gymuser.name,
        'height': gymuser.height,
        'weight': gymuser.weight,
        'age': gymuser.age,
        'sex': gymuser.sex,
      },
    );
  }

  static GymUser toGymUser(User user,
      [String? id,
      String? email,
      String? name,
      String? height,
      String? weight,
      String? age,
      String? sex]) {
    return GymUser(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        height: height ?? '',
        weight: weight ?? '',
        age: age ?? '',
        sex: sex ?? '');
  }

  static Future<bool> gymUserExists(User? user) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('gymusers').doc(user!.uid);

      final doc = await docRef.get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}
