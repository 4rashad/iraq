import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iraq/l10n/l10n.dart';
import 'package:iraq/model/myProviderData.dart';
import 'package:iraq/other/content.dart';
import 'package:iraq/screen/newPost.dart';
import 'package:iraq/screen/profile.dart';
import 'package:provider/provider.dart';
import 'first.dart';
import 'screen/homeSignIn.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return ChangeNotifierProvider(
      create: (context) => MyDataNote(),
      child: MaterialApp(
        title: 'Flutter Login',
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        initialRoute: MyRoots.checkScreen,
        routes: {
          MyRoots.home: (context) => HomeSignIn(),
          MyRoots.profile: (context) => MyProfile(),
          MyRoots.checkScreen: (context) => MyCheck(),
          MyRoots.homeSinIn: (context) => HomeSignIn(),
          MyRoots.newPost: (context) => NewPost(),
        },
      ),
    );
  }
}
