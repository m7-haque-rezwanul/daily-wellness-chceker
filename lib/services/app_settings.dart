
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();

  static final AppSettings instance = AppSettings._();

  bool darkMode = false;
  bool notificationsEnabled = false;
  bool dailyReminder = false;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    darkMode = prefs.getBool('dark_mode') ?? false;
    notificationsEnabled =
        prefs.getBool('notifications_enabled') ?? false;
    dailyReminder =
        prefs.getBool('daily_reminder') ?? false;

    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);

    darkMode = value;
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);

    notificationsEnabled = value;
    notifyListeners();
  }

  Future<void> setDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('daily_reminder', value);

    dailyReminder = value;
    notifyListeners();
  }
}
