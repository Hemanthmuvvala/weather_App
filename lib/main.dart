
import 'package:flutter/material.dart';
import 'package:new_pro2/weather_home_screen.dart';

void main() {
  runApp(const Weather_app());
}

class Weather_app extends StatelessWidget {
  const Weather_app({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:ThemeData.dark(useMaterial3:true),
      debugShowCheckedModeBanner:false,
      home:const weather_home_screen(),
    );
  }
}

