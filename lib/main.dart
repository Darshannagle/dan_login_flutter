import 'package:dan_login_flutter/pages/HomePage.dart';
import 'package:dan_login_flutter/pages/auth_page.dart';
import 'package:dan_login_flutter/pages/signUp_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/loginPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('binding complated');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: AuthPage(),
      // AuthPage(),
      routes:{'/signUp':(context)=> SignUpPage(),
        '/auth': (context)=>AuthPage(),
      '/home':(context)=>HomePage(),
        // ignore: prefer_const_constructors
        '/login':(context)=>LoginPage()
      },
    );
  }
}
