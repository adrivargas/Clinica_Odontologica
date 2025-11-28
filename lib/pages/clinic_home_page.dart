
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicHomePage extends StatelessWidget {
  const ClinicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clínica Odontológica')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Cuidamos tu sonrisa con tratamientos personalizados.',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/registro'),
              child: const Text('Registro de paciente'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/presupuesto'),
              child: const Text('Presupuesto de tratamiento'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/agenda'),
              child: const Text('Agenda de la semana'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/tratamientos'),
              child: const Text('Tratamientos del día'),
            ),
          ],
        ),
      ),
    );
  }
}
