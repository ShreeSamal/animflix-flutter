import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrendingAnime extends StatelessWidget {
  final List trending;
  var result;
  var episode;
  TrendingAnime({super.key, required this.trending});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Trending Anime',
            style: GoogleFonts.breeSerif(
              fontSize: 26,
            )),
        Container(
            height: 270,
            child: ListView.builder(
                itemExtent: 160.0,
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()));
                        var url = Uri.parse(
                            'https://api.consumet.org/anime/gogoanime/info/' +
                                trending[index]['id'].toString());
                        var response = await http.get(url);
                        result = jsonDecode(response.body);

                        if (result != '') {
                          Navigator.of(context).pop();

                          Navigator.pushNamed(context, '/anime',
                              arguments: {'anime': result});
                        } else {
                          CircularProgressIndicator();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                                //width: 250,
                                height: 192,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          trending[index]['image']),
                                      fit: BoxFit.cover),
                                )),
                            const SizedBox(height: 10),
                            Container(
                              child: Text(trending[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ),
                      ));
                }))
      ]),
    );
  }
}
