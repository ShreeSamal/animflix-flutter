import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
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

Widget buildUserName(username) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'User Name',
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
          controller: username,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xff2c68dc),
              ),
              hintText: 'User Name',
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

Widget buildRegisterBtn(email, password, username, context) {
  Future signUp(email, password, username) async {
    try {
      debugPrint(email.text);
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      var user = FirebaseAuth.instance.currentUser!;
      await user.updateDisplayName(username.text.trim());

      Navigator.pushNamed(context, '/login');
    } catch (e) {
      debugPrint(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text(e.toString()),
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
        onPressed: () => {signUp(email, password, username)},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'Register',
          style: TextStyle(
              color: Color(0xffFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )),
  );
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
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
                        'Register Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      buildEmail(email),
                      SizedBox(height: 30),
                      buildUserName(username),
                      SizedBox(height: 30),
                      buildPassword(password),
                      SizedBox(height: 30),
                      buildRegisterBtn(email, password, username, context),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already A User? ',
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Login',
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
