import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'no_internet.dart';

class Gallery extends StatefulWidget {
  Gallery(this.arguments, {Key key}) : super(key: key);
  var arguments;
  @override
  _GalleryState createState() => _GalleryState(arguments);
}

class _GalleryState extends State<Gallery> {
  _GalleryState(this.arguments);
  var arguments, folder;
  var all_photos = [];
  var internetStatus = true;

  @override
  void initState() {
    checkInternetConnection();
    folder = json.decode(arguments);
    print(folder);
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
    return !internetStatus
        ? NoInternet()
        : Scaffold(
            appBar: AppBar(
              leading: null,
              backgroundColor: Colors.black87,
              title: Text('${folder["name"]}'),
            ),
            body: GridView.builder(
              itemCount: folder['files'].length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                all_photos.add(folder["files"][index]["url"]);
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'photo',
                          arguments: all_photos.join(',') + '+$index');
                    },
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        // decoration: BoxDecoration(border: Border.all(color: Colors.black26), color: Colors.black12),
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        height: 150,
                        child: FittedBox(
                          child:
                              Image.network('${folder["files"][index]["url"]}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ]));
              },
            ),
          );
  }
}
