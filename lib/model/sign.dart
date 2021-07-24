import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MySignOptions {
  static String name, email, url;
  static String uid;

  static Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = userCredential.user;
    name = user.displayName;
    email = user.email;
    url = user.photoURL;
    return uid;
  }

  static Future<void> signInWithFacebook() async {
    await Firebase.initializeApp();
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    User user = userCredential.user;
    uid = user.uid;
    email = user.email;
    url = user.photoURL;
  }

  static User myCreanteUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }
}

class MyDbRW {
  static FirebaseDatabase databasee;

  static void updatText({String newText, String textId}) {
    DatabaseReference myDatabaseChild = FirebaseDatabase.instance
        .reference()
        .child(MySignOptions.myCreanteUser().uid);
    myDatabaseChild.child(textId).set(newText);
  }

  static void deleltText({String textId}) {
    DatabaseReference myDatabaseChild = FirebaseDatabase.instance
        .reference()
        .child(MySignOptions.myCreanteUser().uid);
    myDatabaseChild.child(textId).remove();
  }

  static void newPost({String newText}) async {
    DatabaseReference myDatabaseChild = FirebaseDatabase.instance
        .reference()
        .child(MySignOptions.myCreanteUser().uid);
    //  await myDatabaseChild.keepSynced(true);
    myDatabaseChild.push().set(newText);
  }

  static Future<DataSnapshot> getDatabaseSnap() async {
    DatabaseReference myDatabaseChild = FirebaseDatabase.instance
        .reference()
        .child(MySignOptions.myCreanteUser().uid);
    databasee = FirebaseDatabase.instance;
    databasee.setPersistenceEnabled(true);
    databasee.setPersistenceCacheSizeBytes(100000000);

    await myDatabaseChild.keepSynced(true);
    return await myDatabaseChild.orderByKey().once();
  }
}
