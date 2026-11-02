
import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = HabitStore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: AppBar(
        title: const Text('My Favourites'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          final favorites = store.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favourites yet.\n'
                    'Tap the heart icon on a habit to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Your Favourite Habits',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              for (final habit in favorites)
                HabitCard(
                  habit: habit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(habit: habit),
                      ),
                    );
                  },
                  onFavorite: () => store.toggleFavorite(habit),
                  onCompleted: () => store.toggleCompleted(habit),
                ),
            ],
          );
        },
      ),
    );
  }
}
