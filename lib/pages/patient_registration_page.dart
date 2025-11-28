import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({super.key});

  @override
  State<PatientRegistrationPage> createState() => _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String treatmentType = 'Limpieza';
  String resultText = '';

  @override
  void dispose() {
    fullNameController.dispose();
    idController.dispose();
    super.dispose();
  }

  void registerPatient() {
    final name = fullNameController.text.trim();
    final id = idController.text.trim();

    if (name.isEmpty || id.isEmpty || treatmentType.isEmpty) {
      setState(() {
        resultText = 'Completa todos los datos antes de registrar.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faltan datos por completar')),
      );
      return;
    }

    setState(() {
      resultText = 'Paciente $name registrado para $treatmentType.';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro guardado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de paciente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/sonrisa.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Documento o cédula',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: treatmentType,
              items: const [
                DropdownMenuItem(
                  value: 'Limpieza',
                  child: Text('Limpieza'),
                ),
                DropdownMenuItem(
                  value: 'Ortodoncia',
                  child: Text('Ortodoncia'),
                ),
                DropdownMenuItem(
                  value: 'Endodoncia',
                  child: Text('Endodoncia'),
                ),
                DropdownMenuItem(
                  value: 'Estética',
                  child: Text('Estética'),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Tratamiento principal',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  treatmentType = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: registerPatient,
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
