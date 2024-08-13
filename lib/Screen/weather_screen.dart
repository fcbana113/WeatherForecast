import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherforecast/Screen/weather_detail.dart';
import '../Provider/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final List<Map<String, dynamic>> provinces = [
    {'name': 'Hà Nội', 'latitude': 21.0285, 'longitude': 105.8542},
    {'name': 'TP. Hồ Chí Minh', 'latitude': 10.8231, 'longitude': 106.6297},
    {'name': 'Đà Lạt', 'latitude': 11.9404, 'longitude': 108.4583},
    {'name': 'Đồng Nai', 'latitude': 10.9261, 'longitude': 106.8233},
    // Thêm các tỉnh khác ở đây
  ];

  // Tìm kiếm tỉnh
  List<Map<String, dynamic>> _filteredProvinces = [];

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredProvinces = provinces; // Khởi tạo danh sách tìm kiếm
    _searchController.addListener(() {
      _filterProvinces();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProvinces() {
    setState(() {
      _filteredProvinces = provinces
          .where((province) => province['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Thời Tiết',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm tỉnh...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProvinces.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        title: Text(
                          _filteredProvinces[index]['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          await weatherProvider.fetchWeather(
                              _filteredProvinces[index]['latitude'],
                              _filteredProvinces[index]['longitude']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherDetail(
                                weather: weatherProvider.weatherData!,
                                formattedDate:
                                    DateFormat.yMMMMd().format(DateTime.now()),
                                formattedTime:
                                    DateFormat.jm().format(DateTime.now()),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
