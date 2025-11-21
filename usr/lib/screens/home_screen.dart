import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/mcq_model.dart';
import 'package:couldai_user_app/screens/reading_mode_screen.dart';
import 'package:couldai_user_app/screens/test_mode_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _topicController = TextEditingController();
  final _countController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Mock data for demonstration
  final List<MCQ> _mockMCQs = [
    MCQ(
      question: "What is the capital of France?",
      options: ["Berlin", "Madrid", "Paris", "Rome"],
      correctAnswerIndex: 2,
      explanation: "Paris is the capital and most populous city of France.",
    ),
    MCQ(
      question: "Which planet is known as the Red Planet?",
      options: ["Earth", "Mars", "Jupiter", "Venus"],
      correctAnswerIndex: 1,
      explanation: "Mars is often called the 'Red Planet' because of its reddish appearance.",
    ),
    MCQ(
      question: "What is the largest mammal in the world?",
      options: ["Elephant", "Blue Whale", "Giraffe", "Great White Shark"],
      correctAnswerIndex: 1,
      explanation: "The blue whale is the largest animal on the planet, weighing as much as 200 tons.",
    ),
     MCQ(
      question: "Who wrote 'To Kill a Mockingbird'?",
      options: ["Harper Lee", "J.K. Rowling", "Ernest Hemingway", "Mark Twain"],
      correctAnswerIndex: 0,
      explanation: "Harper Lee published 'To Kill a Mockingbird' in 1960, and it was an immediate success.",
    ),
    MCQ(
      question: "What is the chemical symbol for water?",
      options: ["O2", "H2O", "CO2", "NaCl"],
      correctAnswerIndex: 1,
      explanation: "H2O is the chemical formula for water, representing its composition of two hydrogen atoms and one oxygen atom.",
    ),
  ];

  void _generateMCQs(BuildContext context, bool isTestMode) {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would use the topic and count to call an AI service.
      // For now, we'll just use the mock data.
      if (isTestMode) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestModeScreen(mcqs: _mockMCQs),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReadingModeScreen(mcqs: _mockMCQs),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCQ Generator AI'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Create Your Quiz',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _topicController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Topic',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a topic';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _countController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Questions',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of questions';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => _generateMCQs(context, false),
                  child: const Text('Reading Mode'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _generateMCQs(context, true),
                  child: const Text('Test Mode'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
