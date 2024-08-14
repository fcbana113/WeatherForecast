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
   DateTime localTime;
  int hour;

  // Kiểm tra và tính toán thời gian địa phương từ API
  if (weather.timestamp != null && weather.timezoneOffset != null) {
    localTime = DateTime.fromMillisecondsSinceEpoch(
      (weather.timestamp! + weather.timezoneOffset!) * 1000,
      isUtc: true,
    );
  } else {
    // Nếu dữ liệu từ API không hợp lệ, sử dụng giờ hiện tại của thiết bị
    localTime = DateTime.now();
  }

  // Lấy giờ từ thời gian địa phương
  hour = localTime.hour;
    // Lựa chọn hình ảnh dựa trên điều kiện thời tiết
    String imagePath;
    String backgroundImagePath;
    if (hour >= 6 && hour < 18) {
      // Ban ngày: 6h sáng đến 6h chiều
      backgroundImagePath = 'assets/day.gif';
    } else {
      // Ban đêm: 6h chiều đến 6h sáng
      backgroundImagePath = 'assets/night.gif'; 
    }
    if (weather.weather.isNotEmpty) {
      switch (weather.weather[0].main.toLowerCase()) {
        case 'rain':
          imagePath = 'assets/rain.png';
         backgroundImagePath= 'assets/thunder.gif';
          break;
        case 'snow':
          imagePath = 'assets/snowy.png';
          break;
        case 'sunny':
          imagePath = 'assets/sunny.png';
          break;
        case 'thunderstorm':
          imagePath = 'assets/storm.png';
          backgroundImagePath= 'assets/thunder.gif';
          break;
        case 'clouds':
          imagePath = 'assets/cloudy.png';
          break;
        default:
          imagePath = hour >= 6 && hour < 18 ? 'assets/default.png' : 'assets/default_night.png';
          break;
      }
    } else {
      imagePath = hour >= 6 && hour < 18 ? 'assets/default.png' : 'assets/default_night.png';
    }
    return Scaffold(
     
      body: Stack(
        children: [
          // Hiển thị hình nền dựa trên thời gian
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
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
                  "${weather.temperature.current.toStringAsFixed(0)}°C",
                  style: const TextStyle(
                    fontSize: 60,
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
                    //color: Color.fromARGB(255, 0, 0, 0),
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
        ],
      ),
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          shadows: [
            Shadow(
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.5),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          shadows: [
            Shadow(
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.5),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    ],
  );
  }
}
