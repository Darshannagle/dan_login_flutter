import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
      Navigator.popAndPushNamed(context, '/home');
      setState(() {
        isLoading = false;
      });
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("logged in successfully")));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = true;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text("Log In ",style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [ Icon(Icons.security,size: 200,color: Colors.green,),
                SizedBox(height: 80),
                TextFormField(
                  controller: _email,
                  validator: (text) {
                    if ((text == null) || (text.isEmpty)) {
                      return ' Email is empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      icon: Icon(Icons.mail,color: CupertinoColors.activeBlue,),
                      labelText: "Email",labelStyle: TextStyle(color: Colors.lightBlue)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextFormField(
                  controller: _pass,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (text) {
                    if ((text == null) || (text.isEmpty)) {
                      return ' Pass is empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      icon: Icon(Icons.shield,color: CupertinoColors.activeBlue,),
                      labelText: "Password",labelStyle: TextStyle(color: Colors.lightBlue)),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CupertinoColors.activeBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("validation is done");
                      signInWithEmailAndPassword();
                    }
                  },
                  label: (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text("SignIn"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.activeBlue,foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  icon: Icon(Icons.send_and_archive),
                  onPressed: () {
                    // FirebaseAuth.instance.a
                    Navigator.popAndPushNamed(context, '/signUp');
                  },
                  label: Text("SignUp ?"),
                ),SizedBox(height: 20,)

              ,Text("Name : Darshan Nagle \n  Enrollment Number : 12002040701019",textAlign: TextAlign.center,)],

            ),
          ),
        )));
  }
}
