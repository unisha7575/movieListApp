import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list/movie_list_model.dart';
import 'my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  MovieListModel? movieData;

  Future<dynamic> post() async {
    http.Response data = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      body: {
        "category": "movies",
        "language": "kannada",
        "genre": "all",
        "sort": "voting"
      },
    );
    // var response = utf8.decode(data.bodyBytes);
    if (data == null) {
      //show toast
    } else {
      log("Line32: ${data.body}");
      setState(() {
        movieData = MovieListModel.fromJson(json
            .decode(data.body.toString())); //movieListModelFromJson(response);
        isLoading = false;
        // var a = movieData.result[0].title;
      });
    }
    print("Line22: ${data}");

    print("line23:${http.Response}");
  }

  @override
  void initState() {
    // TODO: implement initState
    post();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var _poster = movieData!.result!.length;
    return SafeArea(
        child: Scaffold(
            //backgroundColor: Colors.red,
            appBar: AppBar(),
            drawer: const MyDrawer(),
            body: (isLoading)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 12.0),
                        Text("Please wait...")
                      ],
                    ),
                  )
                : ListView(
                    children: List.generate(movieData!.result!.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        // height: 200,
                        // width: MediaQuery.of(context).size.width*0.8,

                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.keyboard_arrow_up_outlined,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          movieData!.result![index].voting
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Votes',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                       0.23,
                                    width: 100,
                                    child: Image(
                                      image: NetworkImage(movieData!
                                          .result![index].poster
                                          .toString()),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 3),
                                            child: Text(
                                              movieData!.result![index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Genre  : ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      " ${movieData!.result![index].genre.toString()}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Director : ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      " ${movieData!.result![index].director![0].toString()}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Starring :',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${movieData!.result![index].stars![0].toString()}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(movieData!.result![index]
                                                          .runTime ==
                                                      null
                                                  ? ''
                                                  : movieData!
                                                      .result![index].runTime
                                                      .toString()),
                                              SizedBox(
                                                width: movieData!.result![index]
                                                            .runTime ==
                                                        null
                                                    ? 0
                                                    : 7,
                                              ),
                                              Text(movieData!
                                                  .result![index].language
                                                  .toString(),style: TextStyle(
                                                  fontSize: 10,color: Colors.black54),),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                '|',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 20),
                                              ),


                                            ],
                                          ),
                                          Text(DateTime
                                              .fromMillisecondsSinceEpoch(
                                              movieData!
                                                  .result![index]
                                                  .releasedDate!)
                                              .toString()
                                              .split(" ")
                                              .first,style: TextStyle(color: Colors.black54,fontSize: 10),),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${movieData!.result![index].pageViews.toString()} Views",
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue),
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              const Text(
                                                '|',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  " voted by ${movieData!.result![index].voting.toString()} people ",
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.blue),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                //height: 35,
                                width:
                                    MediaQuery.of(context).size.width * 0.9,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Watch Trailer",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))));
  }
}
