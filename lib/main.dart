import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenflow/pages/main_screen.dart';
import 'package:zenflow/providers/filter_provider.dart';
import 'package:zenflow/providers/meditation_provider.dart';
import 'package:zenflow/providers/mindfull_exercise_provider.dart';
import 'package:zenflow/providers/sleep_content_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MindfullExerciseProvider()),
        ChangeNotifierProvider(create: (context) => MeditationProvider()),
        ChangeNotifierProvider(create: (context) => SleepContentProvider()),
        ChangeNotifierProvider(create: (context) => FilterdDataprovider()),
      ],
      child: MyApp(),
    ),
  );
}
