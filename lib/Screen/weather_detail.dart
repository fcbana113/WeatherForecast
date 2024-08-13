import 'package:flutter/material.dart';
import 'package:weatherforecast/Model/weather_model.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    // Lựa chọn hình ảnh dựa trên điều kiện thời tiết
    String imagePath;
    if (weather.weather.isNotEmpty) {
      switch (weather.weather[0].main.toLowerCase()) {
        case 'rain':
          imagePath = 'assets/rain.png';
          break;
        case 'snow':
          imagePath = 'assets/snowy.png';
          break;
        case 'sunny':
          imagePath = 'assets/sunny.png';
          break;
        case 'thunderstorm':
          imagePath = 'assets/storm.png';
          break;
        case 'clouds':
          imagePath = 'assets/cloudy.png';
          break;
        default:
          imagePath = 'assets/default.png';
          break;
      }
    } else {
      imagePath = 'assets/default.png';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF676BD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      backgroundColor: const Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị tên địa điểm
            Text(
              weather.name,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Hiển thị nhiệt độ hiện tại
            Text(
              "${weather.temperature.current.toStringAsFixed(2)}°C",
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Hiển thị trạng thái thời tiết
            if (weather.weather.isNotEmpty)
              Text(
                weather.weather[0].main,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            // Hiển thị ngày và giờ
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị hình ảnh dựa trên điều kiện thời tiết
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Chi tiết thời tiết khác
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wind_power,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Wind",
                                value: "${weather.wind.speed}km/h"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.sunny,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Max",
                                value:
                                    "${weather.maxTemperature.toStringAsFixed(2)}°C"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wind_power,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Min",
                                value:
                                    "${weather.minTemperature.toStringAsFixed(2)}°C"),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.water_drop,
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Humidity",
                                value: "${weather.humidity}%"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.air,
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Pressure",
                                value: "${weather.pressure}hPa"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.leaderboard,
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 5),
                            weatherInfoCard(
                                title: "Sea-Level",
                                value: "${weather.seaLevel}m"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
