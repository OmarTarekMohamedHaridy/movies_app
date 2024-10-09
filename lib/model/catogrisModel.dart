class catagorisModel {
  List<Genres>? genres;

  catagorisModel({this.genres});

  catagorisModel.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
  }


}

class Genres {
  int? id;
  List<String>? names;

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['key'] != null) {
      names = List<String>.from(json['key'].map((item) => item.toString()));
    } else {
      names = ["Action",
        "Adventure",
        "Animation",
        "Comedy",
        "Drama",
        "Fantasy",
        "Historical",
        "Horror",
        "Musical",
        "Mystery",
        "Romance",
        "Science Fiction",
        "Thriller",
        "War",
        "Western",
        "Documentary",
        "Family",
        "Crime",
        "western"]; // Default to an empty list if 'key' is null
    }
  }
}