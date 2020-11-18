import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
            child: Text(
          '${value.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white, fontFamily: "DidactGothic"),
        )),
        SizedBox(height: 5),
        Container(
          height: 70,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff54E360),
                      borderRadius: BorderRadius.circular(3)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontFamily: "DidactGothic"),
        ),
      ],
    );
  }
}
