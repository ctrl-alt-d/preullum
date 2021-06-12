import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_app2/services/luzservice.dart';

class GraficBarres extends StatelessWidget {
  final List<Preu> preus;

  GraficBarres({Key? key, required this.preus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barres = preus
        .map((Preu e) => BarChartGroupData(x: e.hour, barRods: [
              BarChartRodData(y: e.price, width: 15, colors: [Colors.amber]),
            ]))
        .toList();

    return BarChart(
      BarChartData(
        borderData: FlBorderData(
          border: Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          ),
        ),
        barGroups: barres,
      ),
    );
  }
}
