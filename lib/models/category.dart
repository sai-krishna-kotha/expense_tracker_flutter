import 'package:flutter/material.dart';


enum Category {
  food("food", Icons.lunch_dining, Colors.blue),
  travel("travel", Icons.flight_takeoff, Colors.green),
  shopping("shopping", Icons.shopping_bag, Colors.orange),
  entertainment("entertainment", Icons.movie, Colors.purple),
  health("health", Icons.medical_services, Colors.red),
  others("others", Icons.more_horiz, Colors.grey);

  const Category(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;

  @override
  String toString() => label;
}