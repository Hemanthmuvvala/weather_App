import 'package:flutter/material.dart';
class hourly_Forecast extends StatelessWidget {
 
  final String time;
  final String temperature;
   final IconData icon;
  final Color color;
  const hourly_Forecast({
    super.key,
    
    required this.time,
    required this.temperature,
    required this.icon,
    required this.color,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Column(
          children: [
            Text(
             time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
         const   SizedBox(height: 8),
            Icon(
              icon,
              size: 32,
              color:color,
            ),
           const  SizedBox(height: 8),
            Text(temperature)
          ],
        ),
      ),
    );
  }
}