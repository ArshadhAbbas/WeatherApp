import 'package:flutter/material.dart';

import 'apis.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // scaffoldBackgroundColor: const Color.fromARGB(255, 169, 216, 255),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

bool isLoading = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cityController = TextEditingController();
  String cityName = "Georgia";
  String? latitude;
  String? longitude;
  String? maxTemp;
  String? minTemp;
  String? temp;
  String? icon;
  String? tempStatus;
  String? pressure;
  String? humidity;
  String? windSpeed;
  String? feelsLike;
  bool isLoading = false; // add a flag to track loading state

  @override
  void initState() {
    super.initState();
    updateWeatherData(cityName);
  }

  

  void updateWeatherData(String cityName) async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await getWeatherdata(cityName: cityName);
      setState(() {
        this.cityName = result.name.toString();
        latitude = result.coord!.lat.toString();
        longitude = result.coord!.lon.toString();
        maxTemp = result.main!.tempMax.toString();
        minTemp = result.main!.tempMin.toString();
        temp = result.main!.temp.toString();
        pressure = result.main!.pressure.toString();
        humidity = result.main!.humidity.toString();
        windSpeed = result.wind!.speed.toString();
        feelsLike = result.main!.feelsLike.toString();
        tempStatus = result.weather![0].main;
        icon = result.weather![0].icon;
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
      Color backgroundColor = const Color.fromARGB(255, 169, 216, 255);

    // Use a switch statement to determine the background color based on the weather condition
    switch (tempStatus) {
      case "Clear":
        backgroundColor = Colors.blue;
        break;
      case "Clouds":
        backgroundColor = Colors.grey;
        break;
      case "Rain":
      case "Drizzle":
      case "Thunderstorm":
        backgroundColor = Colors.blueGrey;
        break;
      case "Snow":
        backgroundColor = Colors.white;
        break;
    }
    return Scaffold(
      backgroundColor: backgroundColor,
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search for location",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      final nameOfCity = cityController.text.toLowerCase();
                     updateWeatherData(nameOfCity);
                    },
                  ),
                ),
              ),
            ),
            if (isLoading) // show loading indicator while loading
              const CircularProgressIndicator()
            else if (latitude == null ||
                longitude == null ||
                maxTemp == null ||
                minTemp == null ||
                temp == null ||
                tempStatus == null ||
                pressure == null ||
                humidity == null ||
                windSpeed == null ||
                icon == null)
              const Text("Please search for a location")
            else
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "$temp°",
                                  style: const TextStyle(fontSize: 60),
                                ),
                                Text(
                                  tempStatus!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text("↑ $maxTemp°c"),
                                Text("↓ $minTemp°c"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        "⌖$cityName",
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text("Latitude : $latitude"),
                      Text("Longitude : $longitude"),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Additional Info",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 300,
                        child: Table(
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Text(
                                  "Pressure",
                                  style: style,
                                ),
                              ),
                              TableCell(
                                  child: Text(
                                " $pressure mBar",
                                style: style,
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Text(
                                  "Humidity",
                                  style: style,
                                ),
                              ),
                              TableCell(
                                  child: Text(
                                " $humidity",
                                style: style,
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Text(
                                  "Wind Speed",
                                  style: style,
                                ),
                              ),
                              TableCell(
                                  child: Text(
                                " $windSpeed km/h",
                                style: style,
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Text(
                                  "Feels like",
                                  style: style,
                                ),
                              ),
                              TableCell(
                                  child: Text(
                                " $feelsLike°c",
                                style: style,
                              ))
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
          ]),
        ),
      ),
    ));
  }
}
