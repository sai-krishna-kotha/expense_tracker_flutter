import './category.dart';

class Expense {
  String title;
  double amount;
  Category category;
  Expense({
    required this.title,
    required this.amount,
    required this.category,
  });
}