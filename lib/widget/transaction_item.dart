import 'package:budgetapp/modal/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final Function deletetx;

  TransactionItem({this.tx, this.deletetx});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Padding(padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                '\$${tx.amount.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(tx.title),
        subtitle: Text(DateFormat.yMMMEd().format(tx.date)),
        trailing: IconButton(
          icon: Icon(Icons.delete),color: Colors.red[400],
          onPressed: () => deletetx(tx.id),
        ),
      ),
    );
  }
}
