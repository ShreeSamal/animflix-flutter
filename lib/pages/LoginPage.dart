import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Widget buildEmail(email) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Email',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xff2c68dc),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black)),
        ),
      )
    ],
  );
}

Widget buildPassword(password) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          controller: password,
          obscureText: true,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff2c68dc),
              ),
              hintText: 'Password ',
              hintStyle: TextStyle(color: Colors.black)),
        ),
      )
    ],
  );
}

Widget buildForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(right: 0),
      child: TextButton(
        onPressed: () => print("Forgot password pressed"),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buildLoginBtn(email, password, context) {
  Future signIn(email, password) async {
    try {
      debugPrint(email.text);
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) => debugPrint('user logged in'));
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      debugPrint(e.toString());
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wrong Credentials'),
            content: Text('Invalid username or password'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    width: double.infinity,
    child: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 3,
        onPressed: () => {signIn(email, password)},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xffFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )),
  );
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      buildEmail(email),
                      SizedBox(height: 30),
                      buildPassword(password),
                      SizedBox(height: 50),
                      buildLoginBtn(email, password, context),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New User? ',
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
