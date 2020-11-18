import 'package:contador_despesas/components/chart_bar.dart';
import 'package:contador_despesas/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool mesmoDia = recentTransaction[i].date.day == weekDay.day;
        bool mesmoMes = recentTransaction[i].date.month == weekDay.month;
        bool mesmoAno = recentTransaction[i].date.year == weekDay.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions.map((tr) {
          return _weekTotalValue == 0
              ? Container(height: 0, width: 0)
              : Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['day'],
                    value: tr['value'],
                    percentage: _weekTotalValue == 0
                        ? 0
                        : (tr['value'] as double) / _weekTotalValue,
                  ),
                );
        }).toList(),
      ),
    );
  }
}
