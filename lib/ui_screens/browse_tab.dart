import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../card/categoryCard.dart';
import '../model/catogrisModel.dart';

  class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Colors.black,
  body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Padding(
  padding: const EdgeInsets.only(top: 20),
  child: Text("Browse Category ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 22,color: Colors.white),),
  ),
  SizedBox(
  height: 20,
  ),
  Expanded(
  child: FutureBuilder(
  future: Api.getCatogoris(),
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
  catagorisModel categorise = snapshot.data;
  List<Genres> genres = categorise.genres ?? [];

  return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 1.5,
  crossAxisSpacing: 10,
  mainAxisSpacing: 15,
  ),
  itemCount: genres.length,
  itemBuilder: (context, index) {
  return categoryCard(index: index,

  );
  },
  );
  },
  ),
  ),
  ],
  ),
  ),
  );
  }
  }
