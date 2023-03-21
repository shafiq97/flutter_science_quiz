import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';

class BumiQuiz extends StatefulWidget {
  const BumiQuiz({super.key});

  @override
  _BumiQuizState createState() => _BumiQuizState();
}

class _BumiQuizState extends State<BumiQuiz> {
  List<dynamic> _questions = [];
  List<String> _selectedValues = [];

  Future<void> _fetchQuestions() async {
    final response =
        await http.get(Uri.parse('http://192.168.68.105:3001/api/data/bumi'));

    if (response.statusCode == 200) {
      setState(() {
        _questions = jsonDecode(response.body)['questions'];
        _selectedValues = List<String>.filled(_questions.length, "");
      });
    } else {
      throw Exception('Failed to fetch questions');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Bumi'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.jpeg'), // Replace with the path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _questions.length,
          itemBuilder: (BuildContext context, int index) {
            final question = _questions[index];
            final choices = question['choices'];
            final image = question['image'];
            var edgeInsets = const EdgeInsets.all(16);
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (image != null && image.isNotEmpty)
                    Padding(
                      padding: edgeInsets,
                      child: Image.asset('assets/images/$image'),
                    ),
                  ...choices.map((choice) => RadioListTile(
                        title: Text(choice),
                        value: choice,
                        groupValue: _selectedValues[index],
                        onChanged: (value) {
                          setState(() {
                            _selectedValues[index] = value;
                          });
                        },
                      ))
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: () {
              int score = 0;
              for (int i = 0; i < _questions.length; i++) {
                final question = _questions[i];
                final correctAnswer = question['answer'];
                final selectedAnswer = _selectedValues[i];
                if (selectedAnswer == correctAnswer) {
                  score++;
                }
              }
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Congratulations!'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          'assets/animations/award.json',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'You scored $score out of ${_questions.length}!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }
}
