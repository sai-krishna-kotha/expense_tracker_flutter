import 'package:flutter/material.dart';


enum Category {
  food("food", Icons.lunch_dining),
  travel("travel", Icons.flight_takeoff),
  shopping("shopping", Icons.shopping_bag),
  entertainment("entertainment", Icons.movie),
  health("health", Icons.medical_services),
  others("others", Icons.more_horiz);

  const Category(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  String toString() => label;
}