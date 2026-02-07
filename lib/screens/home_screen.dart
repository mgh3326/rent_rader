import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('숫자야구', style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 16),
                Text(
                  'Number Baseball',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/game'),
                  child: const Text('새 게임 시작'),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/history'),
                  child: const Text('게임 기록'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
