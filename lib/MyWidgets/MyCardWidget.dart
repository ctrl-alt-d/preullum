import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app2/services/luzservice.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyCardWidget extends StatelessWidget {
  final Preu preu;
  final LuzServiceResult luzServiceResult;

  MyCardWidget({Key? key, required this.preu, required this.luzServiceResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().hour;
    final border = preu.hour == now
        ? new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(4.0))
        : null;
    return Card(
      shape: border,
      child: Padding(
        padding: EdgeInsets.fromLTRB(6, 2, 2, 6),
        child: Column(
          children: [
            MyDetailedData(preu: preu, luzServiceResult: luzServiceResult),
            MyProgressBar(preu: preu, luzServiceResult: luzServiceResult),
          ],
        ),
      ),
    );
  }
}

class MyDetailedData extends StatelessWidget {
  final Preu preu;
  final LuzServiceResult luzServiceResult;

  MyDetailedData({Key? key, required this.preu, required this.luzServiceResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final periode = "${preu.hour.toString().padLeft(2, '0')}:00h";
    final preuTxt = "${(preu.price * 100).toStringAsFixed(1).padLeft(4, ' ')}";
    final fontSize = MediaQuery.of(context).size.width * 0.04;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 4, 2),
          child: Text(periode,
              style:
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 4, 2),
          child: Text(preu.day, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w100)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 4, 2),
          child: Text(preuTxt,
              style:
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 4, 2),
          child: Text(
            "cèntims/kWh",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w100),
          ),
        ),
      ],
    );
  }
}

class MyProgressBar extends StatelessWidget {
  final Preu preu;
  final LuzServiceResult luzServiceResult;

  MyProgressBar({Key? key, required this.preu, required this.luzServiceResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxPreu = max(0.35, luzServiceResult.maxPreu.price);
    final percent = preu.price / maxPreu;
    final now = DateTime.now();
    final esCapDeSetmana =
        now.weekday == DateTime.sunday || now.weekday == DateTime.saturday;
    final color = esCapDeSetmana
        ? Colors.green
        : preu.zone == "valle"
            ? Colors.green
            : preu.zone == "llano"
                ? Colors.yellow
                : Colors.red;

    return LinearPercentIndicator(
      lineHeight: MediaQuery.of(context).size.width * 0.02,
      percent: percent,
      progressColor: color,
    );
  }
}
