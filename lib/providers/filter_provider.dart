import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenflow/models/meditation_model.dart';
import 'package:zenflow/models/mindfull_exercise_model.dart';
import 'package:zenflow/models/sleep_content_model.dart';
import 'package:zenflow/providers/meditation_provider.dart';
import 'package:zenflow/providers/mindfull_exercise_provider.dart';
import 'package:zenflow/providers/sleep_content_provider.dart';

class FilterdDataprovider extends ChangeNotifier {
  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];

  List<dynamic> get filteredData => _filteredData;

  Future<void> getData(BuildContext context) async {
    await Future.delayed(Duration.zero); // Ensures this runs after build

    final List<MindfulnessExercise> mindfullExercise =
        Provider.of<MindfullExerciseProvider>(
          context,
          listen: false,
        ).mindfullExercise;

    final List<SleepContent> sleepContent =
        Provider.of<SleepContentProvider>(context, listen: false).sleepExercise;

    final List<MeditationContent> meditations =
        Provider.of<MeditationProvider>(
          context,
          listen: false,
        ).meditatonExercise;

    _allData = [...mindfullExercise, ...sleepContent, ...meditations];

    _filteredData = _allData;
    notifyListeners();
  }

  void filterData(String category) {
    if (category == "All") {
      _filteredData = _allData;
    } else if (category == "Mindfulness") {
      _filteredData = _allData.whereType<MindfulnessExercise>().toList();
    } else if (category == "Meditation") {
      _filteredData = _allData.whereType<MeditationContent>().toList();
    } else if (category == "Sleep Stories") {
      _filteredData = _allData.whereType<SleepContent>().toList();
    }
    notifyListeners();
  }
}
