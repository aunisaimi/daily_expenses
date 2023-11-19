import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DailyExpensesApp());
}

class Expense {
  final String description;
  final String amount;
  final double totalAmount;


  Expense(this.description, this.amount, this.totalAmount);
}

var totalAmountController;

class EditExpenseScreen extends StatelessWidget {
  final Expense expense;
  final Function(Expense) onSave;

  EditExpenseScreen({super.key,
    required this.expense,
    required this.onSave});

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
 // final TextEditingController totalAmountController = TextEditingController();

  // widget to build method and user interface goes here
  @override
  Widget build(BuildContext context) {
    // initiallize controllers with the current expense details
    descriptionController.text = expense.description;
    amountController.text = expense.amount;
    totalAmountController.text = expense.totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (RM)',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              // save the edited expense details
             onSave(
                 Expense(
                   descriptionController.text,
                     amountController.text,
                   totalAmountController.text,
                     ),
             );

             // navigate back to expenselist screen
              Navigator.pop(context);
            },
            child: const Text('Save'),
            //The concept of navigation is similar with the login where we use
            // the method Navigator.pop() after the user press save button
            // to return to daily expense screen with updated details.

          ),
        ],
      ),
    );
  }
}

class DailyExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseList(),
    );
  }
}

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final List<Expense> expenses = [];
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();



  // lab task
  // Method to calculate and update the total spending
  String calculateTotalSpending() {
    double total = 0.0;
    for (var expense in expenses) {
      total += double.parse(expense.amount);
    }
    return total.toStringAsFixed(2);
  }

  // Navigate to Edit Screen
  void _editExpense(int index){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditExpenseScreen(
              expense: expenses[index],
              onSave: (editedExpense)
          {
            double totalAmount = 0.0;

            setState(() {
              totalAmount += double.parse(editedExpense.amount) -
                  double.parse(expenses[index].amount);
              expenses[index] = editedExpense;

              totalAmountController.text = totalAmount.toString();
            });
          },
          ),
      ),
    );
  }

  void _addExpense() {
    String description = descriptionController.text.trim();
    String amount = amountController.text.trim();
    String totalAmount = totalAmountController.text.trim();

    //description.isNotEmpty && amount.isNotEmpty: This part checks if both the
    // description and amount strings are not empty.
    // It ensures that the user has entered values for both the description
    // and amount before proceeding.
    if (description.isNotEmpty && amount.isNotEmpty) {
      setState(() {
        expenses.add(Expense(description, amount, totalAmount as double),);
        descriptionController.clear();
        amountController.clear();
      });
    }
  }

  void _removeExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (RM)',
              ),
            ),
          ),
          Text(
            'Total Spend (RM): ${calculateTotalSpending()}',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: _addExpense,
            child: const Text('Add Expense',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),

          ),
          Container(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
        child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              // unique key for each item
              return Dismissible(
                  key: Key(expenses[index].amount),
                  background: Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                onDismissed: (direction){
                    //Handle item removal here
                  _removeExpense(index);
                  ScaffoldMessenger.of(context).
                  showSnackBar(const SnackBar(content: Text('Item Dismissed')));
                },
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(expenses[index].description),
                  subtitle: Text('Amount: ${expenses[index].amount}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeExpense(index),
                  ),
              onLongPress: (){
                    _editExpense(index);
              },
              ),
                ),
              );
            },
        ),
        );
    }



 }

