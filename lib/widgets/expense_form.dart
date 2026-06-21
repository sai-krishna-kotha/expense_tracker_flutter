import 'package:flutter/material.dart';
import '../models/category.dart';
class ExpenseForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final VoidCallback onSubmitted;
  final Category? selectedCategory;
  final ValueChanged<Category> onCategoryChanged;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const ExpenseForm({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.onSubmitted,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.selectedDate,
    required this.onDateChanged,
  });


  Future<void> pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null){
      onDateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
            hintText: "Enter title",
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: amountController,
          onSubmitted: (_) {
            onSubmitted();
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            border: OutlineInputBorder(),
            hintText: "Enter amount",
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<Category>(
          value: selectedCategory,
          hint: Text("Select Category"),
          items: Category.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name),
            );
          }).toList(),

          onChanged: (category) {
            if (category != null) {
              onCategoryChanged(category);
            }
          },
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16,),
        InkWell(
          onTap: () => pickDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
            child: Text(
              selectedDate == null
                  ? 'Select Date'
                  : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
            ),
          ),
        ),
      ],
    );
  }

}