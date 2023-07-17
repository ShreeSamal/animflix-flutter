import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/pages/AnimeDetail.dart';
import 'package:movie_app/pages/HomePage.dart';
import 'package:movie_app/pages/CategoryPage.dart';
import 'package:movie_app/pages/Genre.dart';
import 'package:movie_app/pages/Result.dart';
import 'package:movie_app/pages/Video.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/pages/LoginPage.dart';
import 'package:movie_app/pages/Register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      routes: {
        '/category': (context) => Category(),
        '/genre': (context) => const Genre(),
        '/anime': (context) => const AnimeDetail(),
        '/result': (context) => const Result(),
        '/player': (context) => const Video(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong!'),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    ));
  }
}
