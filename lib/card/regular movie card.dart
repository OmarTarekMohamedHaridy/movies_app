
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../firebase/firebase_functions.dart';
import '../model/watch_list_movie.dart';
import '../moviedetails.dart';

class MovieCard extends StatefulWidget {
  final dynamic movieResult;


  MovieCard({
    required this.movieResult,

    super.key,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MovieDetails_page(movieResult: widget.movieResult)),
          );
        },
        child: Card(
          color: Colors.transparent,
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 150,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.movieResult.posterPath != null
                              ? 'https://image.tmdb.org/t/p/w500${widget.movieResult.posterPath}'
                              : 'https://via.placeholder.com/150', // Placeholder image
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                              onTap: () {
                                addMovieToWatchList();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: (widget.movieResult.isSelected == true)
                                    ? Image.asset(
                                    "assets/images/bookmark (1).png")
                                    : Image.asset("assets/images/bookmark.png"),
                              )
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 100,
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            Text(
                              "${widget.movieResult.voteAverage}",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          "${widget.movieResult.title}",
                          style: TextStyle(fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          " ${widget.movieResult.releaseDate}",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addMovieToWatchList() async {
    // Check if the movie is already selected
    if (widget.movieResult.isSelected == true) {
      _showAlreadyAddedDialog();
      return; // Exit the function here
    }

    // Check if the movie already exists in the Firestore collection
    final movieRef = FirebaseFirestore.instance.collection('watchlist');
    final movieQuery = movieRef.where('movie_id', isEqualTo: widget.movieResult.id);
    final movieSnapshot = await movieQuery.get();

    if (movieSnapshot.docs.isNotEmpty) {
      // Movie already exists in Firestore, show dialog
      _showAlreadyAddedDialog();
      return; // Exit the function here
    }

    // Movie does not exist, add it to the collection
    setState(() {
      widget.movieResult.isSelected = true;
    });

    WatchListMovieModel movie = WatchListMovieModel(
      Date: widget.movieResult.releaseDate,
      overview: widget.movieResult.overview,
      movie_id: widget.movieResult.id,
      genres: widget.movieResult.genres,
      backdropPath: widget.movieResult.backdropPath,
      title: widget.movieResult.title,
      isSelected: widget.movieResult.isSelected,
      posterPath: widget.movieResult.posterPath,
    );

    await Firebase_Functions.addTask(movie); // Ensure you await the addition
  }

// Helper method to show the already added dialog
  void _showAlreadyAddedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            'Movie Already Added',
            style: TextStyle(color: Colors.yellow, fontSize: 20),
          ),
          content: Text(
            'This movie is already added to your watch list.',
            style: TextStyle(color: Colors.yellow, fontSize: 20),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.yellow, fontSize: 15),
              ),
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