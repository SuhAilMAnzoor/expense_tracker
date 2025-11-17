📊 Expense Tracker App

A simple and beautiful Flutter application that helps users manage their daily expenses and income. The app allows users to add transactions, view a list of all entries, and delete any transaction using a long press. It supports income/expense differentiation using colored indicators.

📱 Features
✅ Add Transactions

Users can add new transactions with:

Title

Amount

Date

Type (Income or Expense)

✅ Transaction List

Displays all added transactions in a scrollable list

Shows title, amount, and date

Automatically formats income as green and expenses as red

Uses Provider for state management

✅ Delete on Long Press

Long press any transaction to delete it instantly

✅ Beautiful UI Enhancements

Date separator like "Today ————————"

Clean and modern list design

🧩 State Management

The app uses the Provider package to handle:

Adding new transactions

Managing app-wide state

Removing transactions efficiently

🛠️ Technologies Used

Flutter (Dart)

Provider for State Management

Material UI Components

Android/iOS Support

Hive for saving records of transaction

📂 Project Structure
lib/
├── Provider/
│ └── transaction_provider.dart
├── Widgets/
│ └── transaction_list.dart
├── Models/
│ └── transaction.dart
└── main.dart

🚀 How It Works

User opens the app

Adds an income or expense

The transaction list updates instantly

User long-presses a transaction to delete it

Color coding instantly helps identify income/expense

🎯 Purpose of the App

This app is designed for anyone wanting to:

Track daily expenses

Monitor income

Keep financial records in a simple way

Learn Provider State Management through a real project

Understand list UI and CRUD basics in Flutter
