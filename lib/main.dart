import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/weather_provider.dart';
import 'Screen/weather_screen.dart';

void main() {
  runApp(MyApp());
  
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    );
  }
}
