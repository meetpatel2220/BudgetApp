import '../modal/transaction.dart';
import './chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttx;
  Chart(this.recenttx);

  List<Map<String, Object>> get groupedtx {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;
      for (var i = 0; i < recenttx.length; i++) {
        if (recenttx[i].date.day == weekday.day &&
            recenttx[i].date.month == weekday.month &&
            recenttx[i].date.year == weekday.year) {
          totalsum = totalsum + recenttx[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekday), 'amount': totalsum};
    }).toList();
  }

  double get maxSpend {
    return groupedtx.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: groupedtx.map((data) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      maxSpend == 0.0
                          ? 0.0
                          : (data['amount'] as double) / maxSpend));
            }).toList(),
          ),
        ));
  }
}
