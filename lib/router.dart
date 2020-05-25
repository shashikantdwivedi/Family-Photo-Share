import 'package:flutter/material.dart';
import 'entry_page.dart';
import 'home_page.dart';
import 'gallery.dart';
import 'photo_viewer.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => EntryPage());
    case 'home':
      var homePageArguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => HomePage(homePageArguments));
    case 'gallery':
      var galleryArguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => Gallery(galleryArguments));
    case 'photo':
      var photoViewerArguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PhotoViewer(photoViewerArguments));
    default:
      return MaterialPageRoute(builder: (context) => EntryPage());
  }
}
