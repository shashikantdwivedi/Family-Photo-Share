import 'package:flutter/material.dart';
import 'router.dart' as router;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: router.generateRoute,
        title: 'Family Photo Group',
        home: null);
  }
}
