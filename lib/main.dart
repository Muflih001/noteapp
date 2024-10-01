import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:noteapp/views/homeScreen/HomeScreen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('noteBox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
