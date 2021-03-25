import 'package:flutter/material.dart';
import '../modal/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTranx;

  TransactionList(this.transaction, this.deleteTranx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transaction.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'No Data Available!',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    tx: transaction[index], deletetx: deleteTranx);
              },
              itemCount: transaction.length,
            ),
    );
  }
}
