import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_list.dart';
import '../widgets/add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _addExpense(String title, double amount) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((expense) => expense.id == id);
    });
  }

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddExpense(onAddExpense: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseModal,
          ),
        ],
      ),
      body: ExpenseList(expenses: _expenses, onDelete: _deleteExpense),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
