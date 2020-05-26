import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'no_internet.dart';

class PhotoViewer extends StatefulWidget {
  PhotoViewer(this.arguments, {Key key}) : super(key: key);
  var arguments;
  @override
  _PhotoViewerState createState() => _PhotoViewerState(arguments);
}

class _PhotoViewerState extends State<PhotoViewer> {
  _PhotoViewerState(this.arguments);
  String arguments;
  final globalKey = GlobalKey<ScaffoldState>();
  var all_urls;
  var current_url;
  var current_index;
  final snackBarDownloadComplete = SnackBar(
    content: Text('Download Complete'),
    backgroundColor: Colors.green,
  );
  final snackBarDownloadStarted = SnackBar(
    content: Text('Download Started'),
    backgroundColor: Colors.blue,
  );
  var internetStatus = true;

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
  void initState() {
    checkInternetConnection();
    all_urls = arguments.split('+')[0].split(',');
    current_index = int.parse(arguments.split('+')[1]);
    print(all_urls.length);
    print(all_urls);
    print(current_index);
  }

  @override
  Widget build(BuildContext context) {
    return !internetStatus
        ? NoInternet()
        : Scaffold(
            key: globalKey,
            appBar: AppBar(
              leading: null,
              backgroundColor: Colors.black,
              title: Text('${all_urls[current_index].split("/").last}'),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.refresh), onPressed: () {
                  // print('Photo Viewer Refresh Button Tapped');
                  PhotoViewer(arguments);
                })
              ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  globalKey.currentState.showSnackBar(snackBarDownloadStarted);
                  try {
                    // Saved with this method.
                    var imageId = await ImageDownloader.downloadImage(
                            all_urls[current_index],
                            destination: AndroidDestinationType.custom(
                                directory: 'Family Photo Group'))
                        .whenComplete(() =>
                            {globalKey.currentState.showSnackBar(snackBarDownloadComplete)});
                    if (imageId == null) {
                      return;
                    }

                    // Below is a method of obtaining saved image information.
                    // var fileName = await ImageDownloader.findName(imageId);
                    // var path = await ImageDownloader.findPath(imageId);
                    // var size = await ImageDownloader.findByteSize(imageId);
                    // var mimeType = await ImageDownloader.findMimeType(imageId);
                  } on PlatformException catch (error) {
                    print(error);
                  }
                },
                child: Icon(Icons.file_download)),
            body: SwipeDetector(
                onSwipeLeft: () {
                  if (current_index < all_urls.length - 1) {
                    // print('Left Swiped');
                    // print('All URL Length - ${all_urls.length}');
                    // print(all_urls);
                    // print('Current Index - $current_index');
                    setState(() {
                      current_index++;
                    });
                  }
                },
                onSwipeRight: () {
                  if (current_index > 0) {
                    // print('Right Swiped');
                    // print('All URL Length - ${all_urls.length}');
                    // print('Current Index - $current_index');
                    setState(() {
                      current_index--;
                    });
                  }
                },
                child: Container(
                  // margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: Colors.black),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Image.network(all_urls[current_index]),
                    fit: BoxFit.fitWidth,
                  ),
                )),
          );
  }
}
