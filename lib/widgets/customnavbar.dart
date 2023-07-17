import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF292B37),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Icon(
            Icons.home,
            color: Colors.blue,
            size: 30,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/category');
          },
          child: const Icon(
            Icons.category,
            color: Colors.blue,
            size: 30,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.favorite,
            color: Colors.blue,
            size: 30,
          ),
        ),
        InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: const Icon(
            Icons.logout,
            color: Colors.blue,
            size: 30,
          ),
        ),
      ]),
    );
  }
}
