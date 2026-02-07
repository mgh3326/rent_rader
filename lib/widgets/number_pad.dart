import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../theme/app_theme.dart';

class NumberPad extends StatelessWidget {
  final Set<String> usedDigits;
  final Function(String) onDigitPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onClearPressed;
  final bool isInputFull;

  const NumberPad({
    super.key,
    required this.usedDigits,
    required this.onDigitPressed,
    required this.onDeletePressed,
    required this.onClearPressed,
    this.isInputFull = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.border, width: 2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: _buildClearButton(context)),
              const SizedBox(width: 12),
              Expanded(child: _buildDeleteButton(context)),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (row) {
            return Padding(
              padding: row > 0
                  ? const EdgeInsets.only(top: 8)
                  : EdgeInsets.zero,
              child: Row(
                children: List.generate(3, (col) {
                  final digit = (1 + row * 3 + col).toString();
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: col < 2 ? 4 : 0),
                      child: _buildDigitButton(context, digit),
                    ),
                  );
                }),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: _buildDigitButton(context, '0'))],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitButton(BuildContext context, String digit) {
    final isUsed = usedDigits.contains(digit);
    final isDisabled = isUsed || isInputFull;

    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              Vibrate.feedback(FeedbackType.light);
              onDigitPressed(digit);
            },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: isUsed ? AppTheme.background : AppTheme.surface,
          border: Border.all(
            color: isDisabled ? AppTheme.textDisabled : AppTheme.border,
            width: isDisabled ? 1.5 : 2.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            digit,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 32,
              color: isDisabled ? AppTheme.textDisabled : AppTheme.textPrimary,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return InkWell(
      onTap: onDeletePressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border.all(color: AppTheme.border, width: 2.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '←',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 28, height: 1.0),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return InkWell(
      onTap: onClearPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border.all(color: AppTheme.border, width: 2.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            'CLEAR',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1.0),
          ),
        ),
      ),
    );
  }
}
