import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zenflow/models/meditation_model.dart';
import 'package:zenflow/models/mindfull_exercise_model.dart';
import 'package:zenflow/models/sleep_content_model.dart';
import 'package:zenflow/providers/custom_data_provider.dart';
import 'package:zenflow/providers/filter_provider.dart';
import 'package:zenflow/providers/meditation_provider.dart';
import 'package:zenflow/providers/mindfull_exercise_provider.dart';
import 'package:zenflow/providers/sleep_content_provider.dart';
import 'package:zenflow/router/router.dart';
import 'package:zenflow/utils/colors.dart';

void main() async {
  await Hive.initFlutter();

  // register adapters
  Hive.registerAdapter(MeditationContentAdapter());
  Hive.registerAdapter(MindfulnessExerciseAdapter());
  Hive.registerAdapter(SleepContentAdapter());

  // Open Hive box
  await Hive.openBox('meditations_data');
  await Hive.openBox('mindfull_exercises');
  await Hive.openBox('sleep_contents');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MindfullExerciseProvider()),
        ChangeNotifierProvider(create: (context) => MeditationProvider()),
        ChangeNotifierProvider(create: (context) => SleepContentProvider()),
        ChangeNotifierProvider(create: (context) => FilterdDataprovider()),
        ChangeNotifierProvider(create: (context) => CustomDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'zenflow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.lato().fontFamily,
        scaffoldBackgroundColor: AppColors.primaryWhite,
      ),

      routerConfig: RouterClass().router,
    );
  }
}
