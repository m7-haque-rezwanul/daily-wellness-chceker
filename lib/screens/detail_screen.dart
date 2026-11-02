
import 'package:flutter/material.dart';
import '../models/habit.dart';

class DetailScreen extends StatelessWidget {
  final Habit habit;

  const DetailScreen({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final store = HabitStore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: AppBar(
        title: const Text('Habit Details'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Icon(
                habit.icon,
                size: 90,
                color: habit.color,
              ),
              const SizedBox(height: 20),
              Text(
                habit.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                habit.details,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => store.toggleCompleted(habit),
                icon: Icon(
                  habit.isCompleted
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                ),
                label: Text(
                  habit.isCompleted
                      ? 'Mark as Incomplete'
                      : 'Mark as Completed',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => store.toggleFavorite(habit),
                icon: Icon(
                  habit.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  habit.isFavorite
                      ? 'Remove from Favourites'
                      : 'Add to Favourites',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
