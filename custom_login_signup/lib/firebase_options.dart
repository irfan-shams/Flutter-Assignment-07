// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDQOIazzO2IfWZQUHzGOOke6R67Bfc73Ys',
    appId: '1:278479355845:web:0466bb58f067eef2f015ac',
    messagingSenderId: '278479355845',
    projectId: 'fir-class-1-3b8e6',
    authDomain: 'fir-class-1-3b8e6.firebaseapp.com',
    storageBucket: 'fir-class-1-3b8e6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcDeTQSr4AEBYyHFFirTxGsIcTvBMBsFg',
    appId: '1:278479355845:android:08fcec3fbb2948e1f015ac',
    messagingSenderId: '278479355845',
    projectId: 'fir-class-1-3b8e6',
    storageBucket: 'fir-class-1-3b8e6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4nt6fz-kMhe9jEtlMkbbLWCbO0z81j6I',
    appId: '1:278479355845:ios:baee95486f40eadff015ac',
    messagingSenderId: '278479355845',
    projectId: 'fir-class-1-3b8e6',
    storageBucket: 'fir-class-1-3b8e6.firebasestorage.app',
    iosBundleId: 'com.example.customLoginSignup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4nt6fz-kMhe9jEtlMkbbLWCbO0z81j6I',
    appId: '1:278479355845:ios:baee95486f40eadff015ac',
    messagingSenderId: '278479355845',
    projectId: 'fir-class-1-3b8e6',
    storageBucket: 'fir-class-1-3b8e6.firebasestorage.app',
    iosBundleId: 'com.example.customLoginSignup',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDQOIazzO2IfWZQUHzGOOke6R67Bfc73Ys',
    appId: '1:278479355845:web:6145a789437699cbf015ac',
    messagingSenderId: '278479355845',
    projectId: 'fir-class-1-3b8e6',
    authDomain: 'fir-class-1-3b8e6.firebaseapp.com',
    storageBucket: 'fir-class-1-3b8e6.firebasestorage.app',
  );
}
