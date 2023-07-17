import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/customnavbar.dart';

class AnimeDetail extends StatefulWidget {
  const AnimeDetail({super.key});

  @override
  State<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  var result;
  var Anime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Anime = arguments['anime'];
    debugPrint(Anime.toString());
    if (Anime == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.09,
              child: Image.network(
                Anime['image'],
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.7),
                                  spreadRadius: 1,
                                  blurRadius: 8, // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                Anime['image'],
                                height: 250,
                                width: 180,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 50, top: 0),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 8, // changes position of shadow
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()));

                                  var url = Uri.parse(
                                      'https://api.consumet.org/anime/gogoanime/watch/' +
                                          Anime['episodes'][0]['id']);
                                  var response = await http.get(url);
                                  debugPrint(response.toString());
                                  result = jsonDecode(response.body);
                                  if (result != '') {
                                    debugPrint('res send');
                                    Navigator.of(context).pop();

                                    Navigator.pushNamed(context, '/player',
                                        arguments: {
                                          'src': result['sources'][4]['url']
                                        });
                                  } else {
                                    CircularProgressIndicator();
                                  }
                                },
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ))
                        ]),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Anime['title'],
                          style: GoogleFonts.breeSerif(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          Anime['description'],
                          style: GoogleFonts.breeSerif(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 35),
                        Center(
                          child: Text(
                            'Episodes',
                            style: GoogleFonts.breeSerif(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 5,
                          runSpacing: 10,
                          //direction: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Column(children: [
                                for (int i = 0;
                                    i < Anime["episodes"].length;
                                    i++)
                                  InkWell(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) => const Center(
                                              child:
                                                  CircularProgressIndicator()));

                                      var url = Uri.parse(
                                          'https://api.consumet.org/anime/gogoanime/watch/' +
                                              Anime['episodes'][i]['id']);
                                      var response = await http.get(url);
                                      debugPrint(response.toString());
                                      result = jsonDecode(response.body);
                                      if (result != '') {
                                        debugPrint('res send');
                                        Navigator.of(context).pop();

                                        Navigator.pushNamed(context, '/player',
                                            arguments: {
                                              'src': result['sources'][4]['url']
                                            });
                                      } else {
                                        CircularProgressIndicator();
                                      }
                                    },
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[850],
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                              ),
                                            ]),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          child: Row(children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    Anime["image"],
                                                    height: 70,
                                                    width: 90,
                                                    fit: BoxFit.cover)),
                                            const SizedBox(width: 40),
                                            Center(
                                              child: Text(
                                                  "Episode " +
                                                      Anime["episodes"][i]
                                                              ["number"]
                                                          .toString(),
                                                  style: GoogleFonts.breeSerif(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            // Spacer(),
                                            // const Icon(
                                            //   Icons.arrow_forward,
                                            //   color: Colors.white,
                                            //   size: 25,
                                            // )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
        bottomNavigationBar: CustomNavBar(),
      );
    }
  }
}

// showDialog(
//                                           context: context,
//                                           builder: (context) => const Center(
//                                               child:
//                                                   CircularProgressIndicator()));

//                                       var url = Uri.parse(
//                                           'https://animpix.vercel.app/gogoanime/watch/' +
//                                               Anime['episodes'][i]
//                                                   ['episodeId']);
//                                       var response = await http.get(url);
//                                       debugPrint(response.toString());
//                                       result = jsonDecode(response.body);
//                                       debugPrint('result: $result');
//                                       if (result != '') {
//                                         debugPrint('res send');
//                                         Navigator.of(context).pop();

//                                         Navigator.pushNamed(
//                                             context, '/player', arguments: {
//                                           'src': result['sources'][0]['file']
//                                         });
//                                       } else {
//                                         CircularProgressIndicator();
//                                       }