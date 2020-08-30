import 'package:flutter/material.dart';
import 'package:info_capoeira/screens/home_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    OneSignal.shared.init('ba94e8e8-caf5-4c0e-bfc9-9a5daf91a225');

    return MaterialApp(
      title: 'Canal do Youtube',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}