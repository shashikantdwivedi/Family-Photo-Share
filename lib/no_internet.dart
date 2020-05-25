import 'package:flutter/material.dart';
import 'entry_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'no_internet.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: MediaQuery.of(context).size.height,
      // decoration: BoxDecoration(border: Border.all()),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.all(15.0),
            child: Text('No Internet Conncection',
                style: TextStyle(
                    fontFamily: 'Circular Std Black', fontSize: 25.0))),
        RaisedButton(
            onPressed: () async {
              bool result = await DataConnectionChecker().hasConnection;
              if (result == true) {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => EntryPage()));
              }
            },
            color: Colors.black,
            colorBrightness: Brightness.dark,
            child: Text('Retry',
                style: TextStyle(
                    fontFamily: 'Circular Std Black', color: Colors.white)))
      ])),
    )));
  }
}
