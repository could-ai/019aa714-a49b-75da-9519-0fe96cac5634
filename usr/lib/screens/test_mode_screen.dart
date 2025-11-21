import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/mcq_model.dart';
import 'package:couldai_user_app/screens/results_screen.dart';

class TestModeScreen extends StatefulWidget {
  final List<MCQ> mcqs;

  const TestModeScreen({super.key, required this.mcqs});

  @override
  State<TestModeScreen> createState() => _TestModeScreenState();
}

class _TestModeScreenState extends State<TestModeScreen> {
  final PageController _pageController = PageController();
  final List<int?> _userAnswers = [];
  int? _selectedOption;

  @override
  void initState() {
    super.initState();
    _userAnswers.addAll(List<int?>.filled(widget.mcqs.length, null));
  }

  void _nextQuestion(int questionIndex, int selectedOption) {
    setState(() {
      _userAnswers[questionIndex] = selectedOption;
      _selectedOption = null;
    });

    if (questionIndex < widget.mcqs.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            mcqs: widget.mcqs,
            userAnswers: _userAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Mode'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.mcqs.length,
        itemBuilder: (context, index) {
          final mcq = widget.mcqs[index];
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}/${widget.mcqs.length}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          mcq.question,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 25),
                        ...mcq.options.asMap().entries.map((entry) {
                          int optionIndex = entry.key;
                          String optionText = entry.value;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedOption = optionIndex;
                              });
                              Future.delayed(const Duration(milliseconds: 500), () {
                                _nextQuestion(index, optionIndex);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _selectedOption == optionIndex ? Colors.deepPurpleAccent.withOpacity(0.5) : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedOption == optionIndex ? Colors.deepPurpleAccent : Colors.white24,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedOption == optionIndex ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: _selectedOption == optionIndex ? Colors.deepPurpleAccent : Colors.white54,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(optionText)),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
