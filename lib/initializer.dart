import 'package:flutter/material.dart';

class Initializer with ChangeNotifier {
  var allFileAndFolders;
  var dataFetched = false;

  void setAllFileAndFolders(value) {
    allFileAndFolders = value;
    notifyListeners();
  }

  void setDataFetchedTrue() {
    dataFetched = true;
  }
}