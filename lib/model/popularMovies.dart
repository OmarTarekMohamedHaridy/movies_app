
import 'package:movies_app/model/popularMovies.dart';

import '../api/movie.dart';
import '../api/source_response.dart';

class popularMovies {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  popularMovies({this.page, this.results, this.totalPages, this.totalResults});

  popularMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class results {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  List<Genres>? genres;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;bool? isSelected;
  double? voteAverage;
  int? voteCount;

  results(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.genres,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,this.isSelected,
        this.voteAverage,
        this.voteCount});

  results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    genres = json ['geners'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    isSelected = json["isSelected"];
  }

}