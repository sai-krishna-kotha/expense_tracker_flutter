import 'package:flutter/material.dart';

class EmptyExpenseView extends StatelessWidget {
  const EmptyExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            "No expense added yet.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Add your first expense above.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

