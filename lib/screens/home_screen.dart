
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/habit.dart';
import '../widgets/habit_card.dart';
import '../widgets/settings_menu.dart';

import 'detail_screen.dart';
import 'favourites_screen.dart';
import 'wellness_tips_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final habitStore = HabitStore.instance;

    final username = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : 'Wellness User';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,

        title: const Row(
          children: [
            Icon(
              Icons.spa,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Daily Wellness',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        actions: [
          // External API integration screen.
          IconButton(
            tooltip: 'Weather & Wellness',
            icon: const Icon(Icons.cloud_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const WellnessTipsScreen(),
                ),
              );
            },
          ),

          // Open favourite habits.
          IconButton(
            tooltip: 'My Favourites',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const FavoritesScreen(),
                ),
              );
            },
          ),

          // Settings menu with five menu items.
          const SettingsMenu(),
        ],
      ),

      body: AnimatedBuilder(
        animation: habitStore,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Welcome section.
              Text(
                'Hello, $username!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Build healthy habits, one day at a time.',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 30),

              // Today's progress.
              Card(
                color: Theme.of(context)
                    .brightness ==
                    Brightness.dark
                    ? Theme.of(context)
                    .colorScheme
                    .surfaceContainerHigh
                    : const Color(0xFFE0F2E3),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),

                      LinearProgressIndicator(
                        value: habitStore.progress,
                        minHeight: 12,
                        borderRadius:
                        BorderRadius.circular(10),
                        backgroundColor:
                        Theme.of(context)
                            .colorScheme
                            .surface,
                        valueColor:
                        const AlwaysStoppedAnimation<
                            Color>(
                          Color(0xFF2E7D32),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        '${habitStore.completedCount} '
                            'of ${habitStore.habits.length} '
                            'habits completed',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Habits heading.
              const Text(
                'Your Daily Habits',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Habit cards.
              ...habitStore.habits.map((habit) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: HabitCard(
                    habit: habit,

                    // Open habit detail screen.
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            habit: habit,
                          ),
                        ),
                      );
                    },

                    // Save favourite status.
                    onFavorite: () {
                      habitStore.toggleFavorite(habit);
                    },

                    // Save completion status.
                    onCompleted: () {
                      habitStore.toggleCompleted(habit);
                    },
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Quick access to API screen.
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.cloud_outlined,
                    color: Color(0xFF2E7D32),
                    size: 32,
                  ),
                  title: const Text(
                    'Weather & Wellness',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'View live weather and '
                        'wellness suggestions',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const WellnessTipsScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
