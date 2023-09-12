import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading= false;
  @override
  Widget build(BuildContext context) {
    double inpWidth = MediaQuery.sizeOf(context).width*0.7;
    return Scaffold(appBar: AppBar(title:Text("Sign Up "),backgroundColor: Colors.blue,foregroundColor: Colors.white,),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [SizedBox(height: 80),
                    Container(width: inpWidth,
                      child: TextFormField(
                        controller: _email,
                        validator: (text) {
                          if ((text == null) || (text.isEmpty)) {
                            return ' Email is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width:1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                            icon: Icon(Icons.mail,color: Colors.blue,),
                            labelText: "Email",labelStyle: TextStyle(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Container(width:   inpWidth,
                      child: TextFormField(
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
                                borderSide: BorderSide(color: Colors.blue, width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                            icon: Icon(Icons.shield,color: Colors.blue,),
                            labelText: "Password",labelStyle: TextStyle(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.activeBlue,foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      icon: Icon(Icons.send_and_archive),
                      onPressed: () {
                        // FirebaseAuth.instance.a
                        createUserWithEmailAndPassword();
                      },
                      label: (isLoading)? CircularProgressIndicator(color: Colors.white,) :  Text("SignUp"),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.activeBlue,foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      icon: Icon(Icons.send),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      label: (isLoading)? Center(child: CircularProgressIndicator(color: Colors.white,)) : Text("SignIn"),
                    ),


                  ],
                ),
              ),
            )));

  }


  createUserWithEmailAndPassword() async{
    try { setState(() {
      isLoading=true;
    });
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _pass.text ,
      );
      setState(() {
        isLoading=false;
      });
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered Successfully ') ));

    } on FirebaseAuthException catch (e) { setState(() {
      isLoading=false;
    });
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text('The password provided is too weak.') ));
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
  }
}
