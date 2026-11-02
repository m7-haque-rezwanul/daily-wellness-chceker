
import 'package:flutter/material.dart';
import '../services/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: settings,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Appearance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Card(
                child: SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text('Dark Mode'),
                  subtitle: const Text(
                    'Use a dark appearance for the app',
                  ),
                  value: settings.darkMode,
                  onChanged: settings.setDarkMode,
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Card(
                child: SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_active,
                  ),
                  title: const Text('Enable Notifications'),
                  subtitle: const Text(
                    'Allow wellness reminders',
                  ),
                  value: settings.notificationsEnabled,
                  onChanged: settings.setNotificationsEnabled,
                ),
              ),

              Card(
                child: SwitchListTile(
                  secondary: const Icon(Icons.alarm),
                  title: const Text('Daily Reminder'),
                  subtitle: const Text(
                    'Remember your daily wellness habits',
                  ),
                  value: settings.dailyReminder,
                  onChanged: settings.notificationsEnabled
                      ? settings.setDailyReminder
                      : null,
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Daily Wellness Checker'),
                  subtitle: const Text('Version 1.0.0'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Daily Wellness Checker',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                      'Wellness and habit tracking app',
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
