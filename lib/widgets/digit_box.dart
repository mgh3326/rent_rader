import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum DigitBoxState { empty, filled, strike, ball, out }

class DigitBox extends StatelessWidget {
  final String? digit;
  final DigitBoxState state;
  final double? size;

  const DigitBox({
    super.key,
    this.digit,
    this.state = DigitBoxState.empty,
    this.size,
  });

  Color get _backgroundColor {
    switch (state) {
      case DigitBoxState.strike:
        return AppTheme.boxFilled;
      case DigitBoxState.ball:
        return AppTheme.boxLight;
      case DigitBoxState.out:
        return AppTheme.background;
      default:
        return AppTheme.surface;
    }
  }

  Color get _textColor {
    switch (state) {
      case DigitBoxState.strike:
        return AppTheme.surface;
      case DigitBoxState.out:
        return AppTheme.textDisabled;
      default:
        return AppTheme.textPrimary;
    }
  }

  Color get _borderColor {
    switch (state) {
      case DigitBoxState.out:
        return AppTheme.textDisabled;
      case DigitBoxState.empty:
        return AppTheme.border.withAlpha(77);
      default:
        return AppTheme.border;
    }
  }

  double get _borderWidth {
    switch (state) {
      case DigitBoxState.empty:
        return 1.5;
      default:
        return 2.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? 56.0;

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(color: _borderColor, width: _borderWidth),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          digit ?? '',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: boxSize * 0.5,
            color: _textColor,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
