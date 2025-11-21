import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/mcq_model.dart';

class ResultsScreen extends StatelessWidget {
  final List<MCQ> mcqs;
  final List<int?> userAnswers;

  const ResultsScreen({
    super.key,
    required this.mcqs,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    for (int i = 0; i < mcqs.length; i++) {
      if (userAnswers[i] == mcqs[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }
    double score = (correctAnswers / mcqs.length) * 100;

    List<Widget> wrongAnswersWidgets = [];
    for (int i = 0; i < mcqs.length; i++) {
      if (userAnswers[i] != mcqs[i].correctAnswerIndex) {
        wrongAnswersWidgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q: ${mcqs[i].question}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your Answer: ${userAnswers[i] != null ? mcqs[i].options[userAnswers[i]!] : "Not Answered"}',
                  style: const TextStyle(color: Colors.redAccent),
                ),
                Text(
                  'Correct Answer: ${mcqs[i].options[mcqs[i].correctAnswerIndex]}',
                  style: const TextStyle(color: Colors.greenAccent),
                ),
                const Divider(height: 20, color: Colors.white24),
              ],
            ),
          ),
        );
      }
    }

    // Approximate screen dimensions for Realme 5i (20:9 aspect ratio)
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${score.toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You got $correctAnswers out of ${mcqs.length} correct!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (wrongAnswersWidgets.isNotEmpty)
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review Your Mistakes',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView(
                            children: wrongAnswersWidgets,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Try Another Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
