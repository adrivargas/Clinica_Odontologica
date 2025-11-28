
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentBudgetPage extends StatefulWidget {
  const TreatmentBudgetPage({super.key});

  @override
  State<TreatmentBudgetPage> createState() => _TreatmentBudgetPageState();
}

class _TreatmentBudgetPageState extends State<TreatmentBudgetPage> {
  String treatmentType = 'Limpieza';
  String sessionsText = '';
  String resultText = '';

  final Map<String, double> prices = {
    'Limpieza': 20,
    'Caries': 30,
    'Ortodoncia': 50,
    'Estética': 40,
  };

  void calculateBudget() {
    final sessions = int.tryParse(sessionsText) ?? 0;
    if (sessions <= 0) {
      setState(() {
        resultText = 'Ingresa una cantidad de sesiones válida.';
      });
      return;
    }
    final price = prices[treatmentType] ?? 0;
    final total = price * sessions;
    setState(() {
      resultText =
        'Tratamiento: $treatmentType\n'
        'Sesiones: $sessions\n'
        'Total estimado: \$${total.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuesto de tratamiento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: treatmentType,
              items: prices.keys
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(t),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Tipo de tratamiento',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  treatmentType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad de sesiones',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                sessionsText = value;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: calculateBudget,
              child: const Text('Calcular presupuesto'),
            ),
            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
