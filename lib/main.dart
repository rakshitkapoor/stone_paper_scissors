import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/Screens/create_room_screen.dart';
import 'package:stone_paper_scissors/Screens/game_screen.dart';
import 'package:stone_paper_scissors/Screens/join_room_screen.dart';
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/Screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bg),
        home: const HomePage(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName:(context)=>  GameScreen(name: "",roomId: "",key: null),
        });
  }
}
