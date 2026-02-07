import 'package:flutter/material.dart';
import '../models/guess_result.dart';
import '../theme/app_theme.dart';
import 'digit_box.dart';

class GuessRow extends StatelessWidget {
  final GuessResult result;

  const GuessRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ...result.guess.split('').map((digit) {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: DigitBox(
                digit: digit,
                state: DigitBoxState.filled,
                size: 48,
              ),
            );
          }),
          const Spacer(),
          _buildResultText(context),
        ],
      ),
    );
  }

  Widget _buildResultText(BuildContext context) {
    if (result.isOut) {
      return Text(
        'OUT',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppTheme.textDisabled,
          fontSize: 14,
        ),
      );
    }

    final parts = <String>[];
    if (result.strikes > 0) {
      parts.add('${result.strikes}S');
    }
    if (result.balls > 0) {
      parts.add('${result.balls}B');
    }

    return Text(
      parts.join(' '),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppTheme.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
