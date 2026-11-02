
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Habit {
  final String id;
  final String title;
  final String description;
  final String details;
  final IconData icon;
  final Color color;

  bool isCompleted;
  bool isFavorite;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.details,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.isFavorite = false,
  });
}

class HabitStore extends ChangeNotifier {
  HabitStore._();

  static final HabitStore instance = HabitStore._();

  final List<Habit> habits = [
    Habit(
      id: 'water',
      title: 'Drink Water',
      description: 'Stay hydrated throughout the day',
      details:
      'Drinking enough water supports your health. '
          'Keep a water bottle nearby and drink regularly.',
      icon: Icons.water_drop,
      color: Colors.blue,
    ),
    Habit(
      id: 'exercise',
      title: 'Daily Exercise',
      description: 'Move your body and stay active',
      details:
      'Regular physical activity supports fitness '
          'and wellbeing. Try walking, stretching or cycling.',
      icon: Icons.fitness_center,
      color: Colors.orange,
    ),
    Habit(
      id: 'meditation',
      title: 'Meditation',
      description: 'Take time to relax your mind',
      details:
      'Find a quiet place, breathe slowly and '
          'focus on the present moment for a few minutes.',
      icon: Icons.self_improvement,
      color: Colors.purple,
    ),
    Habit(
      id: 'sleep',
      title: 'Healthy Sleep',
      description: 'Build a consistent sleep routine',
      details:
      'Try to maintain regular sleep and wake times. '
          'Create a comfortable environment for rest.',
      icon: Icons.bedtime,
      color: Colors.indigo,
    ),
  ];

  int get completedCount =>
      habits
          .where((habit) => habit.isCompleted)
          .length;

  double get progress =>
      habits.isEmpty ? 0 : completedCount / habits.length;

  List<Habit> get favorites =>
      habits.where((habit) => habit.isFavorite).toList();

  // Load saved data when the app starts.

  Future<void> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();

    for (final habit in habits) {
      habit.isCompleted =
          prefs.getBool('completed_${habit.id}') ?? false;

      habit.isFavorite =
          prefs.getBool('favorite_${habit.id}') ?? false;

      debugPrint(
        'LOADED ${habit.id}: '
            'completed=${habit.isCompleted}, '
            'favorite=${habit.isFavorite}',
      );
    }

    notifyListeners();
  }

  Future<void> toggleCompleted(Habit habit) async {
    final prefs = await SharedPreferences.getInstance();

    final newValue = !habit.isCompleted;

    final success = await prefs.setBool(
      'completed_${habit.id}',
      newValue,
    );

    if (success) {
      habit.isCompleted = newValue;
      notifyListeners();

      debugPrint(
        'SAVED completed_${habit.id} = $newValue',
      );
    } else {
      debugPrint('FAILED to save completed_${habit.id}');
    }
  }

  Future<void> toggleFavorite(Habit habit) async {
    final prefs = await SharedPreferences.getInstance();

    final newValue = !habit.isFavorite;

    final success = await prefs.setBool(
      'favorite_${habit.id}',
      newValue,
    );

    if (success) {
      habit.isFavorite = newValue;
      notifyListeners();

      debugPrint(
        'SAVED favorite_${habit.id} = $newValue',
      );
    } else {
      debugPrint('FAILED to save favorite_${habit.id}');
    }
  }
}
