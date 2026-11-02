
import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onCompleted;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onTap,
    required this.onFavorite,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: habit.color.withValues(alpha: 0.12),
              child: Icon(habit.icon, color: habit.color),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        habit.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Text(
                            'View details',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Column(
              children: [
                IconButton(
                  tooltip: 'Toggle favourite',
                  onPressed: onFavorite,
                  icon: Icon(
                    habit.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: habit.isFavorite
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                Checkbox(
                  value: habit.isCompleted,
                  onChanged: (_) => onCompleted(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
