import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/transaction_provider.dart';
class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;

  void submitData(){
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;
    Provider.of<TransactionProvider>(context, listen: false
    ).addTransaction(title, amount, _isIncome);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: "Amount"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Income", style: TextStyle(color: _isIncome == true ? Colors.green : Colors.black)),
              Switch(value: _isIncome, onChanged: (value){
                setState(() {
                  _isIncome = value;
                });
              }),
              Text("Expense", style: TextStyle(color: _isIncome == false ? Colors.red : Colors.black)),
            ],
          ),
          SizedBox(height: 9,),
          ElevatedButton(onPressed: submitData, child: Text("Add Transaction")
          ),
        ],
      ),
    );
  }
}
