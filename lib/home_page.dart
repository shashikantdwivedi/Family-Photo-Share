import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'no_internet.dart';

class HomePage extends StatefulWidget {
  final String argument;

  const HomePage(this.argument, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(argument);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.arguments);
  var allFilesAndFolders;
  var arguments;
  var internetStatus = true;

  @override
  void initState() {
    checkInternetConnection();
    allFilesAndFolders = json.decode(arguments);
    // allFilesAndFolders = data;
  }

  checkInternetConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      setState(() {
        internetStatus = true;
      });
    } else {
      setState(() {
        internetStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final initializer = Provider.of<Initializer>(context);
    // print(initializer.allFileAndFolders);
    return !internetStatus
        ? NoInternet()
        : Scaffold(
            appBar: AppBar(
              leading: null,
              backgroundColor: Colors.black87,
              title: Text('Photos'),
            ),
            body: GridView.builder(
              itemCount: allFilesAndFolders.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'gallery',
                          arguments: json
                              .encode(allFilesAndFolders[index])
                              .toString());
                    },
                    child: Container(
                        margin: EdgeInsets.all(15.0),
                        child: Column(children: [
                          Icon(Icons.folder,
                              color: Color(0xff5fdde5), size: 100.0),
                          Flexible(
                              child:
                                  Text('${allFilesAndFolders[index]["name"]}'))
                        ])));
              },
            ),
          );
  }
}
