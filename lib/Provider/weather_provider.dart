import 'package:flutter/material.dart';
import '../Model/weather_model.dart';
import '../Services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;
  WeatherService _weatherService = WeatherService();

  WeatherData? get weatherData => _weatherData;

  Future<void> fetchWeather(double latitude, double longitude) async {
    _weatherData = await _weatherService.fetchWeather(latitude, longitude);
    notifyListeners();
  }
}
