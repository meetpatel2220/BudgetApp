import 'package:budgetapp/widget/bottomsheet.dart';
import 'package:budgetapp/widget/chart.dart';
import 'package:budgetapp/widget/transaction_list.dart';
import 'package:intl/intl.dart';

import './modal/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _listdata = [];

  List<Transaction> get recentTransaction {
    return _listdata.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  String title1;
  double amount1;
  DateTime dates1;
  void addValue(String title, double amount, DateTime dates) {
    setState(() {
      if (title == null) {
        title1 = 'null';
      } else {
        title1 = title;
        amount1 = amount;
        dates1 = dates;
        _listdata.add(Transaction(id: 't1', amount: amount1, date: dates1, title: title1));
      }
    });
  }

  void deleteItem(String iid) {
    setState(() {
       _listdata.removeWhere((element) => element.id == iid);
    });
   
  }

  void addNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return BottomSheat(addValue);
        });
  }

  @override
  Widget build(BuildContext context) {
    var appBar1 = AppBar(
      title: Text('Budget App'),
    );
    return Scaffold(
        appBar: appBar1,

        // Chart(recentTransaction)

        // TransactionList(_listdata, deleteItem),
        body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: (MediaQuery.of(context).size.height -
                        appBar1.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                child: Chart(recentTransaction),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar1.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.75,
                child: TransactionList(_listdata, deleteItem),
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    addNewTransaction(context);
                  },
                )));
  }
}
