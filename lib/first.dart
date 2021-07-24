import 'package:flutter/material.dart';
import 'screen/homeSignIn.dart';
import 'package:iraq/model/sign.dart';
import 'screen/profile.dart';

class MyCheck extends StatefulWidget {
  @override
  _MyCheckState createState() => _MyCheckState();
}
class _MyCheckState extends State<MyCheck> {
  @override
  Widget build(BuildContext context) {
    if (MySignOptions.myCreanteUser() == null) {
      return HomeSignIn();
    }
    return MyProfile();
  }
}
