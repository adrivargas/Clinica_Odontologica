
import 'package:go_router/go_router.dart';

import 'pages/clinic_home_page.dart';
import 'pages/patient_registration_page.dart';
import 'pages/treatment_budget_page.dart';
import 'pages/weekly_agenda_page.dart';
import 'pages/daily_treatments_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const ClinicHomePage(),
    ),
    GoRoute(
      path: '/registro',
      builder: (_, __) => const PatientRegistrationPage(),
    ),
    GoRoute(
      path: '/presupuesto',
      builder: (_, __) => const TreatmentBudgetPage(),
    ),
    GoRoute(
      path: '/agenda',
      builder: (_, __) => const WeeklyAgendaPage(),
    ),
    GoRoute(
      path: '/tratamientos',
      builder: (_, __) => const DailyTreatmentsPage(),
    ),
  ],
);
