import 'package:flutter/material.dart';
import 'package:my_app2/services/luzservice.dart';
import 'MyCardWidget.dart';

class MyCardsWidget extends StatelessWidget {
  final LuzServiceResult luzServiceResult;
  final bool nomesFutur;

  MyCardsWidget(
      {Key? key, required this.luzServiceResult, required this.nomesFutur})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now().hour;
    List<MyCardWidget> cartes = luzServiceResult.preus
        .where((preu) => !nomesFutur || preu.hour >= now)
        .map((preu) =>
            MyCardWidget(preu: preu, luzServiceResult: luzServiceResult))
        .toList();

    return ListView(
      padding: EdgeInsets.all(5),
      children: cartes,
    );
  }
}
