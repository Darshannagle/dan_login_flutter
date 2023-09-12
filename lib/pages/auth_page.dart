import 'package:dan_login_flutter/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class AuthPage extends StatelessWidget {
   AuthPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator(color: Colors.blue,);
        }else{
          if(snapshot.hasData){
          //  logged in , navigate to home
           return HomePage();
          }
          else{
            return LoginPage();
          }
        }
        }),
    );
  }
}
