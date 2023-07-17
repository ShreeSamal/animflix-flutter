import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/customnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List trendingAnime = [];
  List topRated = [];
  final myController = TextEditingController();
  var result;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadanime();
    loadtoprated();
    super.initState();
  }

  loadanime() async {
    var url = Uri.parse('https://api.consumet.org/anime/gogoanime/top-airing');
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    setState(() {
      trendingAnime = result["results"];
    });
  }

  loadtoprated() async {
    var url =
        Uri.parse('https://api.consumet.org/anime/gogoanime/top-airing?page=2');
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    setState(() {
      topRated = result["results"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'AnimPix',
                          style: GoogleFonts.breeSerif(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://w7.pngwing.com/pngs/754/2/png-transparent-samsung-galaxy-a8-a8-user-login-telephone-avatar-pawn-blue-angle-sphere-thumbnail.png',
                      height: 40,
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: myController,
                onEditingComplete: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()));
                  var url = Uri.parse(
                      'https://api.consumet.org/anime/gogoanime/' +
                          myController.text.toString());
                  var response = await http.get(url);
                  result = jsonDecode(response.body);

                  if (result != '') {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/result', arguments: {
                      'title': myController.text,
                      'result': result["results"]
                    });
                  } else {
                    const CircularProgressIndicator();
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search",
                    hintStyle: GoogleFonts.breeSerif(
                        color: Colors.white.withOpacity(0.5))),
              ),
            )
          ]),
          if (trendingAnime.isEmpty && topRated.isEmpty) ...[
            const Center(child: CircularProgressIndicator())
          ] else ...[
            TrendingAnime(trending: trendingAnime),
            TopAnime(top: topRated)
          ]
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
