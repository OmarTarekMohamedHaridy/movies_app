import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/api/api_manager.dart';
import '../api/source_response.dart';
import '../card/popularcard.dart';
import '../card/regular movie card.dart';
import '../model/newReleasemovies.dart';
import '../model/topRatedMovies.dart';

class HomeTab extends StatefulWidget {
   HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int BottomIndex = 0 ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
        FutureBuilder(future: ApiManager.getPopularMovies(),

            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Color(0xffFFBB3B),
                        ),
                      ],
                    ));
              }
              if (snapshot.hasError) {
                return const Text("Something went wrong. Try again.");
              }
              if (!snapshot.hasData) {
                return const Text("No data available.");
              }
              List<Results> popularMovies = snapshot.data.results ?? [];
              return Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 0),
                child: CarouselSlider(
                  items: popularMovies.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return PopularCard(movieResult: movie);
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              );
            },),
            Container(
              width: double.infinity,
              height: 350, // Adjust the height as needed
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "New Releases",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: ApiManager.getNewReleasesMovies(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Color(0xffFFBB3B),
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot);
                          return const Text("Something went wrong. Try again.");
                        }
                        if (!snapshot.hasData) {
                          return const Text("No data available.");
                        }
                        List<New_Results> popularMovies =
                            snapshot.data.results ?? [];

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMovies.length,
                            // Set the item count
                            itemBuilder: (context, index) {
                              // Access the element at index
                              New_Results movie = popularMovies[index];
                              return MovieCard(
                                movieResult: movie,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 350, // Adjust the height as needed
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Recomended",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                        future: ApiManager.getTopRatedMovies(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color(0xffFFBB3B),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            print(snapshot);
                            return const Text("Something went wrong. Try again.");
                          }
                          if (!snapshot.hasData) {
                            return const Text("No data available.");
                          }
                          List<TopRatedResult> popularMovies =
                              snapshot.data.results ?? [];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: popularMovies.length,
                              // Set the item count
                              itemBuilder: (context, index) {
                                // Access the element at index
                                TopRatedResult movie = popularMovies[index];
                                return MovieCard(movieResult: movie,

                                );
                              },
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
        ],),
      ),
    );
  }
}
