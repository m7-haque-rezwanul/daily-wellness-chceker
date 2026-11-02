
import 'dart:convert';
import 'package:http/http.dart' as http;

class WellnessWeather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final String observationTime;

  const WellnessWeather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.observationTime,
  });

  String get condition {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode <= 3) return 'Partly cloudy';
    if (weatherCode == 45 || weatherCode == 48) {
      return 'Foggy';
    }
    if (weatherCode >= 51 && weatherCode <= 67) {
      return 'Rain or drizzle';
    }
    if (weatherCode >= 71 && weatherCode <= 86) {
      return 'Snowy';
    }
    if (weatherCode >= 95) return 'Thunderstorms';
    return 'Variable weather';
  }

  String get wellnessSuggestion {
    if (weatherCode >= 95) {
      return 'Thunderstorms are forecast. '
          'Choose an indoor wellness activity.';
    }

    if (weatherCode >= 51 && weatherCode <= 86) {
      return 'Wet weather is possible. '
          'Consider stretching or indoor exercise.';
    }

    if (temperature < 5) {
      return 'It is cold outside. Dress warmly '
          'if you plan to walk.';
    }

    if (temperature > 30) {
      return 'It is very warm. Consider a cooler '
          'time of day for outdoor activity.';
    }

    if (windSpeed > 40) {
      return 'It is windy. Check local conditions '
          'before exercising outdoors.';
    }

    return 'Conditions may be suitable for a walk. '
        'Check your surroundings and enjoy some movement.';
  }
}

class WellnessApiService {
  static final Uri _url = Uri.https(
    'api.open-meteo.com',
    '/v1/forecast',
    {
      'latitude': '51.4545',
      'longitude': '-2.5879',
      'current':
      'temperature_2m,wind_speed_10m,weather_code',
      'timezone': 'Europe/London',
    },
  );

  Future<WellnessWeather> fetchWeather() async {
    final response = await http
        .get(_url)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to fetch weather: ${response.statusCode}',
      );
    }

    final data =
    jsonDecode(response.body) as Map<String, dynamic>;

    final current =
    data['current'] as Map<String, dynamic>;

    return WellnessWeather(
      temperature:
      (current['temperature_2m'] as num).toDouble(),
      windSpeed:
      (current['wind_speed_10m'] as num).toDouble(),
      weatherCode:
      (current['weather_code'] as num).toInt(),
      observationTime:
      current['time'] as String,
    );
  }
}
