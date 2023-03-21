import 'package:flutter/material.dart';
import 'package:programming_quiz/Manusia/manusia.dart';
import 'package:programming_quiz/Bumi/bumi.dart';
import 'package:programming_quiz/Bahan/bahan.dart';
import 'package:programming_quiz/SistemRangkaManusia/sistem.dart';
import 'package:programming_quiz/add_question.dart';
import 'package:programming_quiz/admin.dart';
import 'package:programming_quiz/home.dart';
import 'package:programming_quiz/loginui.dart';
import 'package:programming_quiz/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(initialRoute: '/login', routes: {
    '/menu': (context) => const Menu(),
    '/login': (context) => LoginPage(),
    '/manusia': (context) => const ManusiaQuiz(),
    '/bahan': (context) => const BahanQuiz(),
    '/bumi': (context) => const BumiQuiz(),
    '/sistem': (context) => const SistemQuiz(),
    '/admin': (context) => const Admin(),
    '/home': (context) => const Home(),
    '/addQuestion': (context) => const AddQuestion(),
  }));
}
