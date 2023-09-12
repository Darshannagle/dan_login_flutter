
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),centerTitle: true,actions: [IconButton(onPressed: () async {
       await  FirebaseAuth.instance.signOut();
       Navigator.popAndPushNamed(context,'/login');
       }, icon:Icon(Icons.logout))],),
    body: Center(child: Column(
      children: [
        Text(' CurrentUser :'+ user!.email.toString(),style: TextStyle(fontWeight: FontWeight.bold ),),
      ],
    )),);
  }
}
