import 'package:expense_tracker_app/Widget/add_transaction.dart';
import 'package:expense_tracker_app/Widget/summary_card.dart';
import 'package:expense_tracker_app/Widget/transaction_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: Column(
        children: [
          SummaryCard(),
          Expanded(child: TransactionList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTransaction(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
