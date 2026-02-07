import 'package:flutter/material.dart';
import '../widgets/digit_box.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final answer = args?['answer'] as String? ?? '';
    final attempts = args?['attempts'] as int? ?? 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '축하합니다!',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(fontSize: 36),
                ),
                const SizedBox(height: 16),
                Text(
                  'Correct!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),
                Text('정답', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: answer.split('').map((digit) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DigitBox(
                        digit: digit,
                        state: DigitBoxState.strike,
                        size: 64,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 48),
                Text(
                  '총 $attempts회 시도',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: const Text('홈으로'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/game');
                      },
                      child: const Text('다시 하기'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
