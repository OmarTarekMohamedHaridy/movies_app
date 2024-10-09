import 'package:flutter/material.dart';
import '../ui_screens/movie_list.dart';

class categoryCard extends StatelessWidget {
final int index ;

  categoryCard({required this.index, super.key});

final List<Map<String, dynamic>> categories = [
  {"name": "Action", "id": 28},
  {"name": "Adventure", "id": 12},
  {"name": "Animation", "id": 16},
  {"name": "Comedy", "id": 35},
  {"name": "Crime", "id": 80},
  {"name": "Documentary", "id": 99},
  {"name": "Drama", "id": 18},
  {"name": "Family", "id": 10751},
  {"name": "Fantasy", "id": 14},
  {"name": "History", "id": 36},
  {"name": "Horror", "id": 27},
  {"name": "Music", "id": 10402},
  {"name": "Mystery", "id": 9648},
  {"name": "Romance", "id": 10749},
  {"name": "Science Fiction", "id": 878},
  {"name": "TV Movie", "id": 10770},
  {"name": "Thriller", "id": 53},
  {"name": "War", "id": 10752,},
    {"name": "Western", "id": 37
  },
];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 90,
        width: 158,
        child: InkWell(
          onTap: (){Navigator.pushNamed(context, MovieList.routeName,arguments: categories[index]["id"]);},
          child: Stack(
            children: [
              Image.asset("assets/images/action.jpg",height: 90,width: 158),
              Center(child: Text(categories[index]['name']??'NoName',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
