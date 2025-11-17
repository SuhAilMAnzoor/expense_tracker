import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/transaction_provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final txDate = DateTime(date.year, date.month, date.day);

    if (txDate == today) return "Today";
    if (txDate == today.subtract(Duration(days: 1))) return "Yesterday";

    const weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    if (now.difference(txDate).inDays < 7) {
      return weekdays[txDate.weekday - 1];
    }

    return "${date.day} ${_monthName(date.month)}";
  }

  String _monthName(int m) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    List groupedList = [];
    String? lastHeader;

    for (var tx in transactionProvider.transaction) {
      String header = formatDate(tx.date);

      if (header != lastHeader) {
        groupedList.add({"isHeader": true, "label": header});
        lastHeader = header;
      }

      groupedList.add({"isHeader": false, "data": tx});
    }

    return ListView.builder(
      itemCount: groupedList.length,
      itemBuilder: (context, index) {
        final item = groupedList[index];

        if (item["isHeader"] == true) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 10),
                Text(
                  item["label"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(height: 1, color: Colors.grey.shade400),
                ),
              ],
            ),
          );
        }

        final tx = item["data"];

        return GestureDetector(
          onLongPress: () {
            transactionProvider.removeTransaction(tx.id);
          },
          child: ListTile(
            title: Text(tx.title),
            subtitle: Text(tx.date.toString()),
            trailing: Text(
              "\$${tx.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: tx.isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
