import 'package:aggregate_calculation/agg_calc.dart';
import 'package:flutter/material.dart';

void main () {
  runApp(const MyApp ());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aggregate Calculation',
      debugShowCheckedModeBanner: false,
      home: AggScreen(),
    );
  }
}
