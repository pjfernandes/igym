// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMl0rih7RcXDIABGUUwiPx_htulHw9s2w',
    appId: '1:430704908847:web:7c337bea18998a6fb684da',
    messagingSenderId: '430704908847',
    projectId: 'igym-dbb85',
    authDomain: 'igym-dbb85.firebaseapp.com',
    storageBucket: 'igym-dbb85.appspot.com',
    measurementId: 'G-LFTDNPWS18',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNRvjEpRPQ-tfqqgqmSfxlpRXr5WrwDRs',
    appId: '1:430704908847:android:490ff73f7bf59a0db684da',
    messagingSenderId: '430704908847',
    projectId: 'igym-dbb85',
    storageBucket: 'igym-dbb85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbgVquMT4wb5pD_JW4ABV6qlEbY2BkHmM',
    appId: '1:430704908847:ios:db154c30d9d8ffc8b684da',
    messagingSenderId: '430704908847',
    projectId: 'igym-dbb85',
    storageBucket: 'igym-dbb85.appspot.com',
    androidClientId: '430704908847-1c4888loq8jma0mv3s6i6g61n9o0vs77.apps.googleusercontent.com',
    iosClientId: '430704908847-7l2aoh5g3b5rptg04pnftq59v8jh7q9j.apps.googleusercontent.com',
    iosBundleId: 'com.example.igym',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbgVquMT4wb5pD_JW4ABV6qlEbY2BkHmM',
    appId: '1:430704908847:ios:35d94e37b5cebac2b684da',
    messagingSenderId: '430704908847',
    projectId: 'igym-dbb85',
    storageBucket: 'igym-dbb85.appspot.com',
    androidClientId: '430704908847-1c4888loq8jma0mv3s6i6g61n9o0vs77.apps.googleusercontent.com',
    iosClientId: '430704908847-f48gqpdthtlf9eu002gi7ni894l47oom.apps.googleusercontent.com',
    iosBundleId: 'com.example.igym.RunnerTests',
  );
}
