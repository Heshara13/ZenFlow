import 'package:flutter/material.dart';
import 'package:zenflow/widgets/meditation_form.dart';
import 'package:zenflow/widgets/mindfull_exercise_form.dart';
import 'package:zenflow/widgets/sleep_content_form.dart';

class CreateCustomExercise extends StatefulWidget {
  const CreateCustomExercise({super.key});

  @override
  State<CreateCustomExercise> createState() => _CreateCustomExerciseState();
}

class _CreateCustomExerciseState extends State<CreateCustomExercise> {
  String typeOfContent = 'Meditation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create Page')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Type of Content'),

                  const SizedBox(width: 20),
                  DropdownButton(
                    value: typeOfContent,
                    items:
                        ['Meditation', 'Sleep', 'Mindfulness'].map((
                          String value,
                        ) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        typeOfContent = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //render the form based on the type of content selected
              if (typeOfContent == 'Meditation')
                MeditationForm()
              else if (typeOfContent == 'Sleep')
                SleepContentForm()
              else if (typeOfContent == 'Mindfulness')
                MindFullExerciseForm(),
            ],
          ),
        ),
      ),
    );
  }
}
