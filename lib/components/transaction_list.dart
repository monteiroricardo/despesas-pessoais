import 'package:contador_despesas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class TransactionLIst extends StatelessWidget {
  /*criouse uma classe TransactionList, essa classe espera receber um atributo
  List do tipo Transaction
  Foi criado tambem um construtor que recebe o atributo transaction
  */
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  TransactionLIst(this.transactions, this.onRemove);
  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 540,
      child: transactions.isEmpty
          ? Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 220,
                  child: Image.asset(
                    "assets/images/paper.gif",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Nenhuma transação cadastrada...",
                  style: TextStyle(
                      fontFamily: "DidactGothic",
                      color: Colors.white,
                      fontSize: 17),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Color(0xFF455071),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF262C40).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            NumberFormat('R\$ #.00', 'pt-BR').format(tr.value),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "DidactGothic",
                                fontSize: 20,
                                color: Color(0xff54E360)),
                          ),
                        ],
                      ),
                      title: Text(
                        tr.title,
                        style: TextStyle(
                            fontFamily: "DidactGothic",
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y').format(tr.date),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: "DidactGothic",
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(
                                UniconsLine.trash,
                                color: Colors.red,
                              ),
                              onPressed: () => onRemove(tr.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    ));
  }
}
