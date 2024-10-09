import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/SearchMoviesModel.dart';
import '../model/catogrisModel.dart';
import '../model/popularMovies.dart';


class Api{



  static Future<catagorisModel> getCatogoris() async {
    Uri url = Uri.https("api.themoviedb.org", "3/genre/movie/list", {
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    catagorisModel topRatedmovies = catagorisModel.fromJson(json);
    return topRatedmovies;
  }



  static Future<searchMoivesModel> getSerachedMoives(String query) async {
    Uri url = Uri.https("api.themoviedb.org", "3/search/movie", {
      "query": query,
      "api_key": "2b35d85ca7c37f8cf34c134a92690a97",
    });
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      searchMoivesModel topRatedmovies = searchMoivesModel.fromJson(json);
      return topRatedmovies;
    } else {
      throw Exception('Failed to load movies');
    }
  }




  static Future<searchMoivesModel> getMovies(int? genreId)async{
    var uri = await Uri.https("api.themoviedb.org","3/discover/movie",{
      "with_genres":genreId.toString()
    });
    var response = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader:" Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjgyYmRjOWJjZjBiN2RlYWE5NmMwM2JmMmRlZjhkMiIsIm5iZiI6MTcyODE0MDAyNy42NTM2ODcsInN1YiI6IjY2ZDA2ZTM0NmFiZTgyZGE4ZmQzMzMyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1RleJaT0XxnISF4fUHfmQZtEqXMC76mjQvAeBLUPqqo"
        });
    var json = jsonDecode(response.body);
    debugPrint(response.body);
    searchMoivesModel search = searchMoivesModel.fromJson(json);
    return search;
  }
}
