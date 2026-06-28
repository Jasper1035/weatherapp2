import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app2/weather_model.dart';
import 'package:weather_app2/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final weatherservice = WeatherService(dotenv.env['weatherinfo']!);
  WeatherModel? _weather;

  _fetchData() async {
    String cityName = await weatherservice.getCurrentCity();
    try {
      final weather = await weatherservice.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String weatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/strom.json';
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (_weather == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_weather?.cityName ?? 'loading city'}, CA, USA',
              style: GoogleFonts.poppins(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Lottie.asset(weatherAnimation(_weather?.mainCondition)),
            const SizedBox(height: 20),
            Text(
              'Temparature : ${_weather?.temparature.round()} ℉',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Condition : ${_weather?.mainCondition ?? ''}',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Wind Speed : ${_weather!.windSpeed} mp/h',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
