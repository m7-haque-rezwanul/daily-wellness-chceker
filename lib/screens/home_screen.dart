
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'wellness_tips_screen.dart';
import '../models/habit.dart';
import '../widgets/habit_card.dart';
import 'detail_screen.dart';
import 'favourites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (route) => false,
    );
  }

  void _openDetail(BuildContext context, Habit habit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(habit: habit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final store = HabitStore.instance;

    final username = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : 'User';

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.spa),
            SizedBox(width: 8),
            Text('Daily Wellness'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Favourites',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),

          IconButton(
            tooltip: 'Weather & Wellness',
            icon: const Icon(Icons.cloud_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WellnessTipsScreen(),
                ),
              );
            },
          ),

        ],
      ),

      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Hello, $username!',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Build healthy habits, one day at a time.',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),

              Card(
                color: const Color(0xFFE0F2E3),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: store.progress,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF2E7D32),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${store.completedCount} of '
                            '${store.habits.length} habits completed',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Your Daily Habits',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              for (final habit in store.habits)
                HabitCard(
                  habit: habit,
                  onTap: () => _openDetail(context, habit),
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
