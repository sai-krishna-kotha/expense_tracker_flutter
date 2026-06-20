import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(expense.category.icon, color: expense.category.color,),
      title: Text(expense.title),
      subtitle: Text('${expense.category.label} • ₹${expense.amount.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}