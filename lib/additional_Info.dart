
import 'package:flutter/material.dart';

class additional_Info extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const additional_Info({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color:color,
            ),
          const  SizedBox(height: 8),
            Text(
              label,
              style:const  TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
           const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
