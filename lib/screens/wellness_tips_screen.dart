
import 'package:flutter/material.dart';
import '../services/wellness_api_services.dart';

class WellnessTipsScreen extends StatefulWidget {
  const WellnessTipsScreen({super.key});

  @override
  State<WellnessTipsScreen> createState() =>
      _WellnessTipsScreenState();
}

class _WellnessTipsScreenState
    extends State<WellnessTipsScreen> {
  final WellnessApiService _api = WellnessApiService();

  late Future<WellnessWeather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() {
    _weatherFuture = _api.fetchWeather();
  }

  void _refreshWeather() {
    setState(() {
      _loadWeather();
    });
  }

  Widget _weatherCard(WellnessWeather weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: const Color(0xFFE0F2E3),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.cloud_outlined,
                  size: 75,
                  color: Color(0xFF2E7D32),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Current Weather in Bristol',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  weather.condition,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Wind speed: '
                      '${weather.windSpeed.toStringAsFixed(1)} km/h',
                ),
                const SizedBox(height: 8),
                Text(
                  'Observation: ${weather.observationTime}',
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.spa,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your Wellness Suggestion',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  weather.wellnessSuggestion,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _refreshWeather,
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh Weather'),
        ),
        const SizedBox(height: 12),
        const Text(
          'Weather data: Open-Meteo. '
              'Suggestions are general wellness guidance.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: AppBar(
        title: const Text('Weather & Wellness'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<WellnessWeather>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Could not load weather data.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _refreshWeather,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No weather data available.'),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints:
              const BoxConstraints(maxWidth: 650),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Weather-Based Wellness',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Plan your daily activities with '
                        'the latest available weather data.',
                  ),
                  const SizedBox(height: 20),
                  _weatherCard(snapshot.data!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
