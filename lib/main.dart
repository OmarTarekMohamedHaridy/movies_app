import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui_screens/home.dart';
import 'package:movies_app/ui_screens/movie_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized
  await Firebase.initializeApp();
  options: DefaultFirebaseOptions.currentPlatform;// Initialize Firebase
  runApp(MyApp()); // Run your app
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {HomeScreen.routeName:(context) => HomeScreen(),
              MovieList.routeName :(context) => MovieList()
            },
            initialRoute: HomeScreen.routeName,
          ); // Replace with your actual widget
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return CircularProgressIndicator(); // Show a loading indicator while initializing
      },
    );
  }


}



