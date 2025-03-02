import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_pro2/additional_Info.dart';
import 'package:new_pro2/screens/hourly_Forecast.dart';
import 'package:http/http.dart' as http;
import 'package:new_pro2/secrets.dart';

class weather_home_screen extends StatefulWidget {
  const weather_home_screen({super.key});

  @override
  State<weather_home_screen> createState() => WeatherHomeScreenState();
}

class WeatherHomeScreenState extends State<weather_home_screen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'bhimavaram';
      final res = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherAPIKey'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'Unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 121, 192, 225),
  title: Stack(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          const  Padding(
              padding:  EdgeInsets.fromLTRB(0, 16, 0, 1),
              child:  Icon(Icons.location_on, color: Color.fromARGB(255, 213, 14, 14), size: 24),
            ),
            const SizedBox(width: 5),
            FutureBuilder<Map<String, dynamic>>(
              future: getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...", style: TextStyle(fontSize: 16, color: Colors.white));
                }
                if (snapshot.hasError) {
                  return const Text("Error", style: TextStyle(fontSize: 16, color: Colors.white));
                }

                final cityName = snapshot.data!['city']['name']; 

                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
                  child: Align(
                    child: Text(
                      cityName,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
     const Padding(
        padding:  EdgeInsets.fromLTRB(50, 1, 0, 1),
        child:  Align(
          alignment: Alignment.center,
          child: Text(
            "Weather",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
  actions: [
    IconButton(
      onPressed: () {}, 
      icon: const Icon(Icons.refresh, color: Colors.white),
    ),
  ],
),



      
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'] - 273;
          final roundedTemp = double.parse(currentTemp.toStringAsFixed(1));
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 16,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text("$roundedTemp °C",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 15),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 65,
                                color:currentSky == 'Clouds' || currentSky == 'Rain'? const Color.fromARGB(255, 164, 207, 243):Colors.amber,
                              ),
                              const SizedBox(height: 15),
                              Text(currentSky,
                                  style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i <6; i++)
                        hourly_Forecast(
                          time: data['list'][i + 1]
                              ['dt_txt'], // Extract the time
                          icon: data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? Icons.wb_cloudy
                              : Icons.sunny,
                          color: data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ?const Color.fromARGB(255, 164, 207, 243)
                              : Colors
                                  .amber, // Amber for sunny, white otherwise
                          temperature:
                              (data['list'][i + 1]['main']['temp'] - 273.15)
                                      .toStringAsFixed(1) +
                                  "°C",
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    additional_Info(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$currentHumidity %',
                        color: Colors.blue),
                    additional_Info(
                        icon: Icons.air,
                        label: 'Wind',
                        value: currentWindSpeed.toString(),
                        color: Colors.white),
                    additional_Info(
                        icon: Icons.speed_rounded,
                        label: 'Pressure',
                        value: '$currentPressure hPa',
                        color: const Color.fromARGB(255, 237, 84, 73)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
