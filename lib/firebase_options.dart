// File generated manually for Firebase configuration
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBmAQLqcHKAdsHcKEjrDMDKuZznFo3QgQ4',
    appId: '1:664267765188:web:b16bbf7183c3cce6a46091',
    messagingSenderId: '664267765188',
    projectId: 'sadhana-buddy-be29f',
    authDomain: 'sadhana-buddy-be29f.firebaseapp.com',
    storageBucket: 'sadhana-buddy-be29f.firebasestorage.app',
    measurementId: 'G-49WRL1D4CB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6hsQY04LpD6rfIDrNipzAAgM9WZ4XEGg',
    appId: '1:664267765188:android:ed997c82d3f50502a46091',
    messagingSenderId: '664267765188',
    projectId: 'sadhana-buddy-be29f',
    storageBucket: 'sadhana-buddy-be29f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6D61GUiQj2fyLt_7fbUsUbUzEV3W7Qcs',
    appId: '1:664267765188:ios:cf7063402cf9890ca46091',
    messagingSenderId: '664267765188',
    projectId: 'sadhana-buddy-be29f',
    storageBucket: 'sadhana-buddy-be29f.firebasestorage.app',
    iosBundleId: 'com.example.sadhanaBuddy',
  );
}