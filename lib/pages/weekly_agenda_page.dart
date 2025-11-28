
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeeklyAgendaPage extends StatefulWidget {
  const WeeklyAgendaPage({super.key});

  @override
  State<WeeklyAgendaPage> createState() => _WeeklyAgendaPageState();
}

class _WeeklyAgendaPageState extends State<WeeklyAgendaPage> {
  final List<String> days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];
  final List<TextEditingController> controllers = [];
  String resultText = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < days.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void calculateAgenda() {
    int total = 0;
    for (int i = 0; i < controllers.length; i++) {
      final value = int.tryParse(controllers[i].text.trim()) ?? 0;
      total += value;
    }
    final average = controllers.isEmpty ? 0 : total / controllers.length;
    setState(() {
      resultText =
        'Total de citas en la semana: $total\n'
        'Promedio de citas por día: ${average.toStringAsFixed(1)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de la semana'),
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
            Expanded(
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Citas para ${days[index]}',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: calculateAgenda,
              child: const Text('Calcular resumen semanal'),
            ),
            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
