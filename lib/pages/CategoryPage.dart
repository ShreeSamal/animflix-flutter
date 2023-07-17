import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/widgets/customnavbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Category extends StatelessWidget {
  Category({super.key});
  // ignore: non_constant_identifier_names
  final List GENRES = [
    'Action',
    'Adventure',
    'Anti-Hero',
    'College',
    'Comedy',
    'Drama',
    'Fantasy',
    'Game',
    'Historical',
    'Horror',
    'Kids',
    'Martial Arts',
    'Military',
    'Mythology',
    'Mystery',
    'Parody',
    'Police',
    'Revenge',
    'Romance',
    'Samurai',
    'School',
    'Sci-Fi',
    'Shounen',
    'Space',
    'Sports',
    'Supernatural',
    'Survival',
    'Suspense',
    'Time Travel'
  ];

  // ignore: non_constant_identifier_names
  final List GenresUrl = [
    'https://mcdn.wallpapersafari.com/medium/73/52/9BA8ZQ.jpg',
    'https://mcdn.wallpapersafari.com/medium/47/76/74MSUc.jpg',
    'https://mcdn.wallpapersafari.com/medium/93/56/9LB4lI.jpg',
    'https://mcdn.wallpapersafari.com/medium/12/59/9WwT1r.jpg',
    'https://mcdn.wallpapersafari.com/medium/94/86/pjGtFJ.jpg',
    'https://mcdn.wallpapersafari.com/medium/25/70/Ws2LJE.png',
    'https://mcdn.wallpapersafari.com/medium/51/30/jHZbQ5.jpg',
    'https://mcdn.wallpapersafari.com/medium/53/42/Ehaw64.jpg',
    'https://mcdn.wallpapersafari.com/medium/14/69/kD7qtH.jpg',
    'https://mcdn.wallpapersafari.com/medium/21/78/gDf4mQ.jpg',
    'https://mcdn.wallpapersafari.com/medium/16/16/iNnqth.jpg',
    'https://mcdn.wallpapersafari.com/medium/69/70/53qhFZ.jpg',
    'https://mcdn.wallpapersafari.com/medium/62/55/2YCFQM.jpg',
    'https://mcdn.wallpapersafari.com/medium/62/2/Z4HWL2.jpg',
    'https://mcdn.wallpapersafari.com/medium/44/72/XKlmuA.jpg',
    'https://mcdn.wallpapersafari.com/medium/45/79/EGANJl.jpg',
    'https://mcdn.wallpapersafari.com/medium/94/28/04dZWx.jpg',
    'https://mcdn.wallpapersafari.com/medium/57/89/sKF7i8.jpg',
    'https://mcdn.wallpapersafari.com/medium/76/52/4h0vVQ.jpg',
    'https://mcdn.wallpapersafari.com/medium/75/6/idaOjo.jpg',
    'https://mcdn.wallpapersafari.com/medium/38/59/eEPYmQ.jpg',
    'https://mcdn.wallpapersafari.com/medium/3/5/WKuERO.jpg',
    'https://mcdn.wallpapersafari.com/medium/65/47/LDz1RV.jpg',
    'https://mcdn.wallpapersafari.com/medium/8/46/lQz68m.jpg',
    'https://mcdn.wallpapersafari.com/medium/75/99/kaQKm5.jpg',
    'https://mcdn.wallpapersafari.com/medium/98/53/EPs6Iw.jpg',
    'https://mcdn.wallpapersafari.com/medium/48/57/5dypjt.jpg',
    'https://mcdn.wallpapersafari.com/medium/38/98/htY5BF.jpg',
    'https://mcdn.wallpapersafari.com/medium/80/83/cMBzWP.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //to go back to page
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Discover',
                      style: GoogleFonts.breeSerif(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                for (int i = 0; i < GENRES.length; i++)
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));

                      var url = Uri.parse('https://animpix.vercel.app/genre/' +
                          GENRES[i].toString());
                      var response = await http.get(url);
                      var result = jsonDecode(response.body);

                      if (result != '') {
                        Navigator.of(context).pop();

                        Navigator.pushNamed(context, '/genre',
                            arguments: {'title': GENRES[i], 'result': result});
                      } else {
                        CircularProgressIndicator();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(GenresUrl[i],
                                height: 70, width: 90, fit: BoxFit.cover)),
                        const SizedBox(width: 10),
                        Text(GENRES[i],
                            style: GoogleFonts.breeSerif(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        )
                      ]),
                    ),
                  ),
              ]),
            ),
          ]))),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
