
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentItem {
  final String patient;
  final String treatment;
  final double cost;

  TreatmentItem({
    required this.patient,
    required this.treatment,
    required this.cost,
  });
}

class DailyTreatmentsPage extends StatefulWidget {
  const DailyTreatmentsPage({super.key});

  @override
  State<DailyTreatmentsPage> createState() => _DailyTreatmentsPageState();
}

class _DailyTreatmentsPageState extends State<DailyTreatmentsPage> {
  final TextEditingController patientController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final List<TreatmentItem> treatments = [];
  String resultText = '';

  @override
  void dispose() {
    patientController.dispose();
    treatmentController.dispose();
    costController.dispose();
    super.dispose();
  }

  void addTreatment() {
    final patient = patientController.text.trim();
    final treatment = treatmentController.text.trim();
    final costText = costController.text.trim();

    if (patient.isEmpty || costText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa al menos paciente y costo')),
      );
      return;
    }

    final cost = double.tryParse(costText.replaceAll(',', '.')) ?? 0;
    if (cost <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un costo válido')),
      );
      return;
    }

    setState(() {
      treatments.add(
        TreatmentItem(
          patient: patient,
          treatment: treatment.isEmpty ? 'Sin detalle' : treatment,
          cost: cost,
        ),
      );
      patientController.clear();
      treatmentController.clear();
      costController.clear();
      resultText = '';
    });
  }

  void removeTreatment(int index) {
    setState(() {
      treatments.removeAt(index);
      resultText = '';
    });
  }

  void calculateBilling() {
    if (treatments.isEmpty) {
      setState(() {
        resultText = 'No hay tratamientos registrados.';
      });
      return;
    }
    double total = 0;
    for (int i = 0; i < treatments.length; i++) {
      total += treatments[i].cost;
    }
    final count = treatments.length;
    final average = total / count;
    setState(() {
      resultText =
        'Total facturado en el día: \$${total.toStringAsFixed(2)}\n'
        'Promedio por tratamiento: \$${average.toStringAsFixed(2)}\n'
        'Cantidad de tratamientos: $count';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tratamientos del día'),
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
            TextField(
              controller: patientController,
              decoration: const InputDecoration(
                labelText: 'Nombre del paciente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: treatmentController,
              decoration: const InputDecoration(
                labelText: 'Tratamiento o código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Costo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: addTreatment,
              child: const Text('Agregar tratamiento'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: treatments.isEmpty
                  ? const Center(child: Text('No hay tratamientos registrados.'))
                  : ListView.builder(
                      itemCount: treatments.length,
                      itemBuilder: (context, index) {
                        final item = treatments[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.patient),
                            subtitle: Text(
                              '${item.treatment} - \$${item.cost.toStringAsFixed(2)}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeTreatment(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: calculateBilling,
              child: const Text('Calcular facturación'),
            ),
            const SizedBox(height: 8),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
