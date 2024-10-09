
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../card/SearchCard.dart';
import '../model/SearchMoviesModel.dart';


class MovieList extends StatelessWidget {

   MovieList({super.key});
static const String routeName = "list";
  @override

  Widget build(BuildContext context) {

    final int genreId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back),),),
      body:  Container(
        height: double.infinity,
width:  double.infinity,
      color: Colors.black, // Set the background color of the search results area
      child: FutureBuilder(
        future: Api.getMovies(genreId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(

              child: CircularProgressIndicator(
                color: Color(0xffFFBB3B),
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text("Something went wrong. Try again.");
          }
          if (!snapshot.hasData || snapshot.data.results.isEmpty) {
            return const Text("No data available.");
          }

          List<Results_> SameMovies = snapshot.data.results;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: SameMovies.length,
                itemBuilder: (context, index) {
                  return SearchedMoviesCard(moviemodel: SameMovies[index]);
                },
              ),
            ),
          );
        },
      ),
    ));
  }
}
