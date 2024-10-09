import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/movie.dart';
import 'package:movies_app/api/source_response.dart';

import '../model/newReleasemovies.dart';
import '../model/popularMovies.dart';
import '../model/topRatedMovies.dart';
import '../model/similarmovies.dart';
class ApiManager{
  static Future<SourceResponse> getSources()async{
    var response = await http.get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=en'),
      headers: { HttpHeaders.authorizationHeader:
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjgyYmRjOWJjZjBiN2RlYWE5NmMwM2JmMmRlZjhkMiIsIm5iZiI6MTcyODE0MDAyNy42NTM2ODcsInN1YiI6IjY2ZDA2ZTM0NmFiZTgyZGE4ZmQzMzMyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1RleJaT0XxnISF4fUHfmQZtEqXMC76mjQvAeBLUPqqo"
      });

    final result = jsonDecode(response.body);
    debugPrint(response.body);
    var sourcesResponse = SourceResponse.fromJson(result);
    return sourcesResponse;
  }
  static Future<newReleasemovies> getNewReleasesMovies() async {
    try {
      Uri url = Uri.https("api.themoviedb.org", "3/movie/upcoming", {
        "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
      });

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        print('API Response: $json');

        newReleasemovies newReleasesMovies = newReleasemovies.fromJson(json);

        return newReleasesMovies;
      } else {
        print(
            'Failed to load new releases. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to load new releases. Status code: ${response.statusCode}');
      }
    } on SocketException {
      print('Error: No internet connection');
      throw Exception('No internet connection');
    } on FormatException {
      print('Error: Invalid JSON response');
      throw Exception('Invalid JSON response');
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load new releases');
    }
  }
  static Future<popularMovies> getPopularMovies() async {
    Uri url = Uri.https("api.themoviedb.org", "3/movie/popular", {
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    popularMovies popularmovies = popularMovies.fromJson(json);
    return popularmovies;
  }

  static Future<topRatedMovies> getTopRatedMovies() async {
    Uri url = Uri.https("api.themoviedb.org", "3/movie/top_rated", {
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    topRatedMovies topRatedmovies = topRatedMovies.fromJson(json);
    return topRatedmovies;
  }
  static Future<similar_Movies> getSimilarMovies(int id) async {
    Uri url = Uri.https("api.themoviedb.org", "3/movie/$id/similar", {
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    similar_Movies topRatedmovies = similar_Movies.fromJson(json);
    return topRatedmovies;
  }
  static Future<movie> getmovieDartModel(int id) async {
    Uri url = Uri.https("api.themoviedb.org", "3/movie/$id", {
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    movie topRatedmovies = movie.fromJson(json);
    return topRatedmovies;
  }
  static getMovies(int? genreId)async{
    var uri = await Uri.https("api.themoviedb.org","3/discover/movie",{
      "language":"en-US",
      "with_genres":genreId.toString()
    });
    var response = await http.get(uri,
    headers: {HttpHeaders.authorizationHeader:" Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjgyYmRjOWJjZjBiN2RlYWE5NmMwM2JmMmRlZjhkMiIsIm5iZiI6MTcyODE0MDAyNy42NTM2ODcsInN1YiI6IjY2ZDA2ZTM0NmFiZTgyZGE4ZmQzMzMyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1RleJaT0XxnISF4fUHfmQZtEqXMC76mjQvAeBLUPqqo"
    });
    var json = jsonDecode(response.body);
    debugPrint(response.body);
    var sourceResponse = SourceResponse.fromJson(json);
    return sourceResponse;
  }
}