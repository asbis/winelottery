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
///
///
///

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
    apiKey: 'AIzaSyBwyZHOGznO0e0tWfWBpml7YRp0UqCDq38',
    appId: '1:1007460044781:web:34299c591614ce4dff61e4',
    messagingSenderId: '1007460044781',
    projectId: 'winelottery1',
    authDomain: 'winelottery1.firebaseapp.com',
    storageBucket: 'winelottery1.appspot.com',
    measurementId: 'G-33GXL0GQ0N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSVfV_v6wH_KOHD62KAZKeNV_E5iujevE',
    appId: '1:1007460044781:android:741cb4b3572cec28ff61e4',
    messagingSenderId: '1007460044781',
    projectId: 'winelottery1',
    storageBucket: 'winelottery1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnmjPTTRxOlfpQ_nvw_zZYG4mCc4Lgi70',
    appId: '1:1007460044781:ios:026a493100cd38cdff61e4',
    messagingSenderId: '1007460044781',
    projectId: 'winelottery1',
    storageBucket: 'winelottery1.appspot.com',
    iosClientId:
        '1007460044781-dmn19lbta14kkfthg24fr5mibdpj0aek.apps.googleusercontent.com',
    iosBundleId: 'com.example.winwine',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnmjPTTRxOlfpQ_nvw_zZYG4mCc4Lgi70',
    appId: '1:1007460044781:ios:026a493100cd38cdff61e4',
    messagingSenderId: '1007460044781',
    projectId: 'winelottery1',
    storageBucket: 'winelottery1.appspot.com',
    iosClientId:
        '1007460044781-dmn19lbta14kkfthg24fr5mibdpj0aek.apps.googleusercontent.com',
    iosBundleId: 'com.example.winwine',
  );
}
