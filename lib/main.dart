import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/stories_data.dart';
import 'features/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StoryScreen(users: userFinal),
    );
  }
}
