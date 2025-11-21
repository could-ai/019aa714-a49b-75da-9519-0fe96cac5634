import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/mcq_model.dart';

class ReadingModeScreen extends StatefulWidget {
  final List<MCQ> mcqs;

  const ReadingModeScreen({super.key, required this.mcqs});

  @override
  State<ReadingModeScreen> createState() => _ReadingModeScreenState();
}

class _ReadingModeScreenState extends State<ReadingModeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Mode'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.mcqs.length,
        itemBuilder: (context, index) {
          final mcq = widget.mcqs[index];
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
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
                      bool isCorrect = optionIndex == mcq.correctAnswerIndex;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green.withOpacity(0.3) : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCorrect ? Colors.green : Colors.white24,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isCorrect ? Colors.green : Colors.white54,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(optionText)),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 25),
                    const Text(
                      'Explanation:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                    ),
                    const SizedBox(height: 10),
                    Text(mcq.explanation),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
