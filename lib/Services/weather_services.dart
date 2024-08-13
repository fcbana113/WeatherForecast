// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherforecast/Model/weather_model.dart';

class WeatherService {
  fetchWeather(double latitude,double longitude) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=509079b22fae7e954dff8403ef5eba0e"),
    );
    // now we can cange latitude and longitude and let's see how it perfrom.
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
