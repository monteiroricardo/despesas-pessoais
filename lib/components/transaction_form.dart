import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titlecontroller = TextEditingController();
  final _valuecontroller = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _onSubmit() {
    final title = _titlecontroller.text;
    final value = double.tryParse(_valuecontroller.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        color: Color(0xffEDEFF2),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _onSubmit(),
              controller: _titlecontroller,
              decoration: InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "DidactGothic",
                      fontSize: 17)),
            ),
            TextField(
                onSubmitted: (_) => _onSubmit(),
                controller: _valuecontroller,
                decoration: InputDecoration(
                    labelText: "Valor R\$",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: "DidactGothic",
                        fontSize: 17)),
                keyboardType: TextInputType.numberWithOptions(decimal: true)),
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 17,
                ),
                Text(
                  _selectDate == null
                      ? ' Nenhuma data inserida'
                      : ' Data Selecionada: ${DateFormat('d/MM/y').format(_selectDate)}',
                  style: TextStyle(
                      fontFamily: "DidactGothic",
                      fontSize: 15,
                      color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Alterar data",
                        style: TextStyle(
                            fontFamily: "DidactGothic",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: _onSubmit,
                    child: Icon(
                      Icons.check_circle,
                      size: 50,
                      color: Color(0xFF49A82A),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
