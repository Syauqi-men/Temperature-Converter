import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _input = TextEditingController();
  String _from = 'C', _to = 'F', _total = '';
  final List<String> _unit = ['C', 'F', 'K', 'R'];

  double _convert(double value, String temp, String to) {
    double c = temp == 'C' ? value :
              temp == 'F' ? (value - 32) * 5/9 :
              temp == 'K' ? value - 273.15 :
              temp == 'R' ? value * 5/4 : 0;
    
    if (to == 'C') return c;
    if (to == 'F') return (c * 9/5) + 32;
    if (to == 'K') return c + 273.15;
    if (to == 'R') return c * 4/5;
    return 0;
  }

  void _count() {
    double? value = double.tryParse(_input.text);
    if (value == null) {
      setState(() => _total = 'Input not valid!');
      return;
    }
    if (_from == 'K' && value < 0) {
      setState(() => _total = 'Kelvin cannot negative!');
      return;
    }
    
    double total = _convert(value, _from, _to);
    setState(() {
      _total = '$value°$_from = ${total.toStringAsFixed(2)}°$_to';
    });
  }

  void _reset() {
    setState(() {
      _input.clear();
      _from = 'C';
      _to = 'F';
      _total = '';
    });
  }

  void _swap() {
    setState(() {
      String temp = _from;
      _from = _to;
      _to = temp;
    });
  }

  String _unitName(String s) {
    return {
      'C': 'Celcius', 
      'F': 'Fahrenheit', 
      'K': 'Kelvin', 
      'R': 'Reamur'
      }[s]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Converter'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _input,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Input Temperature',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _dropdown('temp', _from, (v) => _from = v)),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.swap_horiz, size: 30),
                  onPressed: _swap,
                ),
                SizedBox(width: 10),
                Expanded(child: _dropdown('to', _to, (v) => _to = v)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _tombol('COUNT', Colors.blue, _count)),
                SizedBox(width: 10),
                Expanded(child: _tombol('RESET', Colors.red, _reset)),
              ],
            ),
            SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _total.isEmpty ? 'Results here' : _total,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String label, String value, Function(String) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(label),
        items: _unit.map((s) {
          return DropdownMenuItem(value: s, child: Text('${_unitName(s)} ($s)'));
        }).toList(),
        onChanged: (v) => setState(() => onChanged(v!)),
      ),
    );
  }

  Widget _tombol(String teks, Color warna, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: warna,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(teks, style: TextStyle(fontSize: 16)),
    );
  }
}