import 'package:flutter/material.dart';
import 'package:iraq/model/myProviderData.dart';
import 'package:iraq/other/content.dart';
import 'package:iraq/first.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newPost;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.sinPad),
        title: Center(child: Text(AppLocalizations.of(context)?.newNote)),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (e) {
                newPost = e;
              },
            ),
            WillPopScope(
                //  key:fff ,
                child: Text(""),
                onWillPop: () {
                  if (newPost != null && newPost != "") {
                    Provider.of<MyDataNote>(context,listen: false).addNoteP(newPost: newPost);
                  }
                  return  Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (_) => MyCheck()),
                      );
                })
          ],
        ),
      ),
    );
  }
}
