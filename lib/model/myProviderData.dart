import 'package:flutter/material.dart';
import 'package:iraq/model/constClass.dart';
import 'package:iraq/model/sign.dart';

class MyDataNote extends ChangeNotifier {
  List<MyConstract> myReadData = [];
  List get myReadDataRev {
    return myReadData.reversed.toList();
  }

  void delNoteP({int index}) {
    myReadData.removeAt(index);
    notifyListeners();
  }

  void addNoteP({String newPost}) {
    MyDbRW.newPost(newText: newPost);
    myReadData.add(MyConstract(myKey: newPost, myValue: newPost));
    notifyListeners();
  }

  void updataNoteP({String e, String textId, int index}) {
    MyDbRW.updatText(newText: e, textId: textId);
    myReadData[index].myValue = e;
    notifyListeners();
  }
}
