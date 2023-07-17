import 'package:flutter/material.dart';
import 'package:movie_app/widgets/customnavbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Genre extends StatefulWidget {
  const Genre({super.key});

  @override
  State<Genre> createState() => _ResultState();
}

class _ResultState extends State<Genre> {
  var result;
  var title;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    title = arguments['title'];
    result = arguments['result'];
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
                      title,
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
                for (int i = 0; i < result.length; i++)
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));

                      var url = Uri.parse(
                          'https://api.consumet.org/anime/gogoanime/info/' +
                              result[i]['animeId'].toString());
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(result[i]['animeImg'],
                                height: 150, width: 150, fit: BoxFit.cover)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(7),
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                //width: 250,
                                margin: const EdgeInsets.only(top: 45),

                                height: 192,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                //   image: DecorationImage(
                                //       image: NetworkImage(GenresUrl[i]),
                                //       fit: BoxFit.cover),
                                // )),
                                //const SizedBox(height: 10),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      result[i]['animeTitle'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 20),
                                    if (!(result[i]['releaseDate'] is Null))
                                      Text(result[i]['releaseDate'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                        //Spacer(),
                        // const Icon(
                        //   Icons.arrow_forward,
                        //   color: Colors.white,
                        //   size: 25,
                        // )
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
