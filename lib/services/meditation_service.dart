import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zenflow/models/meditation_model.dart';

class MeditationService {
  //craete the Box for Hive
  final _meditationBox = Hive.box('meditations_data');

  //add a new meditation
  Future<void> addMeditation(
    MeditationContent meditation,
    BuildContext context,
  ) async {
    try {
      // Get all the meditations, if any
      final dynamic allMeditations = _meditationBox.get("meditations");

      List<Map<String, dynamic>> meditationList = [];
      if (allMeditations != null && allMeditations is List) {
        meditationList = List<Map<String, dynamic>>.from(allMeditations);
      }

      meditationList.add(meditation.toJson());
      // Save the new list of meditations
      await _meditationBox.put("meditations_data", meditationList);

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Meditation added"),
          duration: Duration(seconds: 2),
        ),
      );
      print("Meditation added");
    } catch (e) {
      print("Service error: $e");
    }
  }

  //get all the meditations
  List<MeditationContent> getMeditations() {
    try {
      // Get all the meditations from Hive
      final dynamic allMeditations = _meditationBox.get("meditations_data");

      if (allMeditations != null && allMeditations is List) {
        return allMeditations.map((item) {
          if (item is Map<String, dynamic>) {
            return MeditationContent.fromJson(item);
          } else {
            return MeditationContent.fromJson(Map<String, dynamic>.from(item));
          }
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("get meditations error: $e");
      return [];
    }
  }

  //delete a meditation
  Future<void> deleteMeditation(
    MeditationContent meditation,
    BuildContext context,
  ) async {
    try {
      // Get all the meditations, if any
      final dynamic allMeditations = _meditationBox.get("meditations_data");

      if (allMeditations != null && allMeditations is List) {
        List<Map<String, dynamic>> meditationList =
            List<Map<String, dynamic>>.from(allMeditations);

        // Remove the meditation
        meditationList.removeWhere((item) {
          MeditationContent currentMeditation = MeditationContent.fromJson(
            Map<String, dynamic>.from(item),
          );
          return currentMeditation.name == meditation.name &&
              currentMeditation.category == meditation.category;
        });

        // Save the new list of meditations
        await _meditationBox.put("meditations_data", meditationList);

        // Show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Meditation deleted"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
