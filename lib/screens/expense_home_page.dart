import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import '../widgets/expense_item.dart';
import '../widgets/expense_form.dart';
import '../widgets/empty_expense_view.dart';
import '../models/category.dart';


class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({
    super.key
  });

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  List<Expense> expenses = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  int? editingIndex;
  Category? selectedCategory;
  DateTime? selectedDate;

  double get totalExpenses {
    double total = 0;
    for (var expense in expenses){
      total += expense.amount;
    }
    return total;
  }

  void addExpense() {
    final String title = titleController.text.trim();
    final double? amount = double.tryParse(amountController.text);
    if (selectedCategory == null || selectedDate == null || title.isEmpty || amount == null || amount <= 0) {
      return;
    }
    setState(() {
      expenses.add(Expense(
        title: title,
        amount: amount,
        category: selectedCategory!,
        date: selectedDate!,
      ));
      selectedCategory = null;
      selectedDate = null;
    });
    titleController.clear();
    amountController.clear();
  }

  void editExpense(int index) {
    setState(() {
      if (index < 0)  {
        editingIndex = null;
        titleController.clear();
        amountController.clear();
        selectedCategory = null;
        selectedDate = null;
        return;
      }
      editingIndex = index;
      titleController.text = expenses[index].title;
      amountController.text = expenses[index].amount.toString();
      selectedCategory = expenses[index].category;
      selectedDate = expenses[index].date;
    });
  }

  void updateExpense() {
    final String title = titleController.text.trim();
    final double? amount = double.tryParse(amountController.text);
    if (editingIndex == null || selectedDate == null || selectedCategory == null || title.isEmpty || amount == null || amount <= 0) {
      return;
    }
    setState(() {
      expenses[editingIndex!].title = title;
      expenses[editingIndex!].amount = amount;
      expenses[editingIndex!].category = selectedCategory!;
      expenses[editingIndex!].date = selectedDate!;
      editingIndex = null;
    });
    titleController.clear();
    amountController.clear();
    selectedCategory = null;
    selectedDate = null;
  }

  void deleteExpense(int index) {

    setState(() {
      if (index == editingIndex) {
        editingIndex = null;
        titleController.clear();
        amountController.clear();
        selectedCategory = null;
        selectedDate = null;
      } else if (editingIndex != null && index < editingIndex!) {
        editingIndex = editingIndex! - 1;
      }
      expenses.removeAt(index);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker!!'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpenseForm(
              titleController: titleController,
              amountController: amountController,
              selectedCategory: selectedCategory,
              selectedDate: selectedDate,
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              onCategoryChanged: (category) {
                // if (category == null) return;
                setState(() => selectedCategory = category);
              },
              onSubmitted: editingIndex == null ? addExpense : updateExpense,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: editingIndex == null ? addExpense : updateExpense,
                  child: Text(editingIndex == null ? 'Add Expense' : 'Update'),
                ),
                if (editingIndex != null) ...[
                  SizedBox(width: 10,),
                  TextButton(onPressed: () => editExpense(-1), child: const Text('Cancel'))
                ],
              ],
            ),
            SizedBox(height: 16,),
            Text(
              "Total: ₹${totalExpenses.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: expenses.isEmpty ?
                  const EmptyExpenseView()
                : ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return ExpenseItem(
                      expense: expense,
                      onEdit: () => editExpense(index),
                      onDelete: () => deleteExpense(index),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
