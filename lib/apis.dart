import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_dummy/weather_model/weather_model.dart';

import 'apikey.dart';

Future<WeatherModel> getWeatherdata({required String cityName}) async {
  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric"));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    final data = WeatherModel.fromJson(jsonData);
    return data;
  } else {
    throw Exception("Cannot found");
  }
}
