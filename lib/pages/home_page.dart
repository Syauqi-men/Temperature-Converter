import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/temp_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TempProvider>(context);

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
              controller: prov.input,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Input Temperature',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.thermostat),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: dropdown(
                    prov,
                    prov.from,
                    (v) => prov.setFrom(v),
                  ),
                ),

                IconButton(
                  onPressed: prov.swap,
                  icon: const Icon(Icons.swap_horiz),
                ),

                Expanded(
                  child: dropdown(
                    prov,
                    prov.to,
                    (v) => prov.setTo(v),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: tombol(
                    'COUNT',
                    Colors.blue,
                    prov.count,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: tombol(
                    'RESET',
                    Colors.red,
                    prov.reset,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                prov.total.isEmpty
                    ? 'Results here'
                    : prov.total,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdown(
    TempProvider prov,
    String value,
    Function(String) onChanged,
  ) {
    return DropdownButton<String>(
      value: value,
      isExpanded: true,
      items: prov.unit.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text('${prov.unitName(e)} ($e)'),
        );
      }).toList(),
      onChanged: (v) => onChanged(v!),
    );
  }

  Widget tombol(
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }
}
