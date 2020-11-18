import 'package:contador_despesas/components/chart.dart';
import 'package:contador_despesas/components/transaction_form.dart';

import 'package:flutter/material.dart';
import './components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transactions.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop(); // fecha o modal
  }

  String value;

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3E4A6D),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => _openTransactionModal(context)),
        ],
        centerTitle: true,
        title: Text(
          "Despesas pessoais",
          style: TextStyle(
            fontFamily: "DidactGothic",
            fontSize: 22,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xff997EEA),
                Color(0xffF775B3),
              ])),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Chart(_recentTransactions),
          TransactionLIst(_transactions, _removeTransaction),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 20,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xff997EEA),
                Color(0xffF775B3),
              ])),
        ),
        onPressed: () => _openTransactionModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
