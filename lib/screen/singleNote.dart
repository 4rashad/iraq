import 'package:flutter/material.dart';
import 'package:iraq/first.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iraq/model/myProviderData.dart';
import 'package:iraq/model/sign.dart';
import 'package:iraq/other/content.dart';
import 'package:provider/provider.dart';

class SingleNote extends StatelessWidget {
  SingleNote({@required this.myValue, this.myIdDb, @required this.index});
  final String myValue;
  final String myIdDb;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.myscafeld),
        title: Text(AppLocalizations.of(context)?.onChange),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  //  key: _formKey,
                  maxLines: 88,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  initialValue: myValue,
                  onChanged: (e) {
                    Provider.of<MyDataNote>(context,listen: false)
                        .updataNoteP(e: e, textId: myIdDb, index: index);
                  },
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
