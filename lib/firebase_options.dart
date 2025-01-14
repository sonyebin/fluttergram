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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCOU5vsojJB3YfRTpVTtw3e4IYIrme9h7E',
    appId: '1:410381845369:web:cd2c7452dbc96ec2d1a5a8',
    messagingSenderId: '410381845369',
    projectId: 'fluttergram-97c32',
    authDomain: 'fluttergram-97c32.firebaseapp.com',
    storageBucket: 'fluttergram-97c32.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPJntpruc6S_Ck_NbcPHeHt-nZf63oZl4',
    appId: '1:410381845369:android:3ddb21bada28ca38d1a5a8',
    messagingSenderId: '410381845369',
    projectId: 'fluttergram-97c32',
    storageBucket: 'fluttergram-97c32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLwYDa0oaLdI2brPMycMmGPckQojMzkkw',
    appId: '1:410381845369:ios:39b364a00a66cf64d1a5a8',
    messagingSenderId: '410381845369',
    projectId: 'fluttergram-97c32',
    storageBucket: 'fluttergram-97c32.appspot.com',
    iosBundleId: 'com.yesempty.fluttergram',
  );
}
