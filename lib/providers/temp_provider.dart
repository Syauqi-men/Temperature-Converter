import 'package:flutter/material.dart';

class TempProvider extends ChangeNotifier {
  final TextEditingController input = TextEditingController();

  String from = 'C';
  String to = 'F';
  String total = '';

  final List<String> unit = ['C', 'F', 'K', 'R'];

  double convert(double value, String temp, String target) {
    double c = temp == 'C'
        ? value
        : temp == 'F'
            ? (value - 32) * 5 / 9
            : temp == 'K'
                ? value - 273.15
                : temp == 'R'
                    ? value * 5 / 4
                    : 0;

    if (target == 'C') return c;
    if (target == 'F') return (c * 9 / 5) + 32;
    if (target == 'K') return c + 273.15;
    if (target == 'R') return c * 4 / 5;

    return 0;
  }

  void count() {
    double? value = double.tryParse(input.text);

    if (value == null) {
      total = 'Input not valid!';
      notifyListeners();
      return;
    }

    if (from == 'K' && value < 0) {
      total = 'Kelvin cannot negative!';
      notifyListeners();
      return;
    }

    double result = convert(value, from, to);

    total = '$value°$from = ${result.toStringAsFixed(2)}°$to';
    notifyListeners();
  }

  void reset() {
    input.clear();
    from = 'C';
    to = 'F';
    total = '';
    notifyListeners();
  }

  void swap() {
    String temp = from;
    from = to;
    to = temp;
    notifyListeners();
  }

  void setFrom(String value) {
    from = value;
    notifyListeners();
  }

  void setTo(String value) {
    to = value;
    notifyListeners();
  }

  String unitName(String s) {
    return {
      'C': 'Celcius',
      'F': 'Fahrenheit',
      'K': 'Kelvin',
      'R': 'Reamur',
    }[s]!;
  }
}
