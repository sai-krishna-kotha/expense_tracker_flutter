import './category.dart';

class Expense {
  String title;
  double amount;
  Category category;
  DateTime date;
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });
}