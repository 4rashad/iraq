import 'package:flutter/material.dart';
import 'package:iraq/model/sign.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:iraq/other/content.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeSignIn extends StatefulWidget {
  @override
  State<HomeSignIn> createState() => _HomeSignInState();
}

class _HomeSignInState extends State<HomeSignIn> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ModalProgressHUD(
            inAsyncCall: _saving,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(Buttons.Google, onPressed: () {
                  setState(() {
                    _saving = true;
                  });
                  
                  MySignOptions.signInWithGoogle().then((value) {
                    Navigator.popAndPushNamed(context, MyRoots.checkScreen);
                  }).catchError((e)=> 
                  Navigator.pushNamed(context, MyRoots.checkScreen));
                }),
                SignInButton(Buttons.Facebook, onPressed: () {
                  setState(() {
                     _saving = true;
                  });
                 
                  MySignOptions.signInWithFacebook().then((value) {
                    Navigator.popAndPushNamed(context, MyRoots.checkScreen);
                  }).catchError((e)=> 
                  Navigator.pushNamed(context, MyRoots.checkScreen));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
