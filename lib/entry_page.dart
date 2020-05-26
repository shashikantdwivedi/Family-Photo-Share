import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'no_internet.dart';

class EntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EntryPage();
}

class _EntryPage extends State<EntryPage> {
  var allFilesAndFolders;
  var internetStatus = true;

  void handleTimeout() {
    // Navigator.pushNamed(context, 'home', arguments: allFilesAndFolders);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => HomePage(allFilesAndFolders)));
  }

  Future getData() async {
    var response = await http.get(Uri.encodeFull(
        'https://06v3s5c65b.execute-api.ap-south-1.amazonaws.com/prod/get-folders-and-files-list'));
    // var data = json.decode(response.body);
    print(response.body);
    allFilesAndFolders = response.body;
  }

  checkInternetConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      setState(() {
        internetStatus = true;
      });
      getData().whenComplete(() => {handleTimeout()});
    } else {
      setState(() {
        internetStatus = false;
      });
    }
  }

  @override
  void initState() {
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return !internetStatus
        ? NoInternet()
        : Container(
            // padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                    width: 400,
                    bottom: -10,
                    left: 0,
                    child: Image.asset('assets/images/entry_bg.png')),
                Positioned(
                    top: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      child: Text(
                        'Photos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Circular Std Black',
                            color: Colors.black87,
                            // fontFamily: 'Circular Std Black',
                            decoration: TextDecoration.none),
                      ),
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.width - 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        // width: 40 ,
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black87,
                      strokeWidth: 1,
                    )),
                  ),
                )
              ],
            ),
          );
  }
}
