import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<LuzServiceResult> fetchPreus(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/jorgeatgu/apaga-luz/main/public/price-postprocessed.json'));

  // Use the compute function to run parsePreus in a separate isolate.
  return compute(_parsePreus, response.body);
}

LuzServiceResult _parsePreus(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  final preus = parsed.map<Preu>((json) => Preu.fromJson(json)).toList();
  return LuzServiceResult(preus: preus);
}

class Preu {
  final String day;
  final int hour;
  final double price;
  final String zone;

  Preu({
    required this.day,
    required this.hour,
    required this.price,
    required this.zone,
  });

  factory Preu.fromJson(Map<String, dynamic> json) {
    return Preu(
      day: json['day'] as String,
      hour: json['hour'] as int,
      price: json['price'] as double,
      zone: json['zone'] as String,
    );
  }
}

class LuzServiceResult {
  final List<Preu> preus;
  late Preu maxPreu;
  late Preu minPreu;

  LuzServiceResult({required this.preus}) {
    maxPreu =
        preus.reduce((curr, next) => curr.price > next.price ? curr : next);
    minPreu =
        preus.reduce((curr, next) => curr.price < next.price ? curr : next);
  }
}
