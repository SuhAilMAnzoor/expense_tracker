import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final List<Transaction> _transaction = [];

  List<Transaction> get transaction => _transaction;

  // Added For Hive
  late Box _box;

  // Added For Hive (Load data when provider is created)
  TransactionProvider() {
    _initHive();
  }

  // Initialize Hive
  Future<void> _initHive() async {
    _box = await Hive.openBox("transactionBox");
    loadTransactions();
  }

  // Load Saved Data
  Future<void> loadTransactions() async {
    final List storedData = _box.get('transactions', defaultValue: []);

    _transaction.clear();
    for (var item in storedData) {
      _transaction.add(Transaction.fromMap(Map<String, dynamic>.from(item)));
    }
    notifyListeners();
  }

  // Save List to Hive
  Future<void> saveTransactionToHive() async {
    List dataToStore = _transaction.map((tx) => tx.toMap()).toList();
    await _box.put('transactions', dataToStore);
  }

  // This function calculates the total income
  double get totalIncome {
    double total = 0;

    // Loop through every transaction in the list
    for (var tx in _transaction) {
      // If the transaction is income (true)
      if (tx.isIncome == true) {
        // Add its amount to total
        total = total + tx.amount;
      }
    }

    // Return the final total income
    return total;
  }

  // for Calculating the total income  -> Short Code
  // double get totalIncome =>
  //     _transaction.where((tx) => tx.isIncome).fold(0, (sum, tx) => sum + tx.amount);
  //

  // This function calculates the total expenses
  double get totalExpenses {
    double total = 0;

    // Loop through every transaction in the list
    for (var tx in _transaction) {
      // If the transaction is NOT income (means it is expense)
      if (tx.isIncome == false) {
        // Add its amount to total
        total = total + tx.amount;
      }
    }

    // Return the final total expenses
    return total;
  }

  //   // for calculating the total expenses -> short Code
  // double get totalExpenses =>
  //     _transaction.where((tx) => !tx.isIncome).fold(0, (sum, tx) => sum + tx.amount);

  //>> for remaining balance
  double get remainingBalance => totalIncome - totalExpenses;

  //>> method to add a new transaction
  void addTransaction(String title, double amount, bool isIncome) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      isIncome: isIncome,
    );
    _transaction.insert(0, newTransaction);

    // Save in Hive
    saveTransactionToHive();

    notifyListeners();
  }

  // method to remove
  void removeTransaction(String id) {
    _transaction.removeWhere((tx) => tx.id == id);

    saveTransactionToHive();

    notifyListeners();
  }
}
