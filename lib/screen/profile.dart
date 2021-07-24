import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iraq/model/constClass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iraq/model/myProviderData.dart';
import 'package:iraq/model/sign.dart';
import 'package:iraq/other/content.dart';
import 'package:iraq/screen/singleNote.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    //  Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(MyColors.myscafeld),
        child: Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MyRoots.newPost);
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(MyColors.myscafeld),
        title: Text(AppLocalizations.of(context)?.notes),
      ),
      drawer: Drawer(
          child: DrawerHeader(
        child: Column(
          children: [
            Text(MySignOptions.myCreanteUser().displayName),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: MySignOptions.myCreanteUser().photoURL,
                  width: 55,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FlatButton(
                onPressed: () {
                  MySignOptions.signOut();
                  Navigator.popAndPushNamed(context, MyRoots.homeSinIn);
                },
                color: Color(MyColors.signOutButton),
                child: Text(AppLocalizations.of(context)?.logOut)),
          ],
        ),
        margin: EdgeInsets.only(bottom: 400),
        decoration: BoxDecoration(color: Color(MyColors.sinPad)),
      )),
      body: Column(
        children: [
          Expanded(child: MyListVi()),
          WillPopScope(child: Text(""), onWillPop: () => exit(0)),
        ],
      ),
    );
  }
}

List<MyConstract> myReadData = [MyConstract(myKey: "", myValue: "")];
Map<dynamic, dynamic> myListMap = {};

class MyListVi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> myMap = {};
    myMap.clear();
    MyDbRW.getDatabaseSnap().then((dataSnap) {
      myMap = dataSnap.value;
      Provider.of<MyDataNote>(context, listen: false).myReadData.clear();
      if (myMap != null) {
        myMap.forEach((key, value) {
          Provider.of<MyDataNote>(context, listen: false)
              .myReadData
              .add(MyConstract(myKey: key, myValue: value));
        });
      }
    });
    return ListView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        itemCount: Provider.of<MyDataNote>(context).myReadData.length,
        itemBuilder: (BuildContext context, int index) {
          final myProvider = Provider.of<MyDataNote>(context);
          if (myProvider.myReadData != null) {
            if (myProvider.myReadData.isNotEmpty) {
              final item = myProvider.myReadDataRev[index].myValue;
              final deleId = myProvider.myReadDataRev[index].myKey;
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)?.remove,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
                ),
                key: Key(item),
                onDismissed: (direction) {
                  MyDbRW.deleltText(textId: deleId);
                  myProvider.delNoteP(
                      index: (myProvider.myReadData.length - index) - 1);
                },
                child: ListTile(
                  title: Container(
                      padding: EdgeInsets.all(9),
                      height: 77,
                      width: 22,
                      decoration: BoxDecoration(
                        color: Color(MyColors.items),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, //[700],
                            blurRadius: 4,
                            offset: Offset(1, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        item,
                        maxLines: 4,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleNote(
                                  myIdDb: deleId,
                                  myValue: item,
                                  index:
                                      ((myProvider.myReadData.length - index) -
                                          1),
                                )));
                  },
                ),
              );
            }
            return Center(child: Text(AppLocalizations.of(context)?.noNotes));
          } else
            return Center(child: Text(AppLocalizations.of(context)?.noNotes));
        });
  }
}
