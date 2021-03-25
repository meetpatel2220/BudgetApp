import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheat extends StatefulWidget {
  final Function tx;
  BottomSheat(this.tx);

  @override
  _BottomSheatState createState() => _BottomSheatState();
}

class _BottomSheatState extends State<BottomSheat> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();
  DateTime selectDate;

  void _percentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10
        ),
       
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: titleInputController,
                decoration: InputDecoration(
                    hintText: 'Enter Title here',
                    contentPadding: EdgeInsets.all(8)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: amountInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter Amount here',
                    contentPadding: EdgeInsets.all(8)),
              ),
            ),
            TextButton(
                onPressed: _percentDatePicker,
                child: Text(selectDate == null
                    ? 'select Date'
                    : DateFormat.yMd().format(selectDate))),
            ElevatedButton(
                onPressed: () {
                  widget.tx(
                      titleInputController.text,
                      double.parse(amountInputController.text),
                      selectDate);
                  Navigator.of(context).pop();
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
