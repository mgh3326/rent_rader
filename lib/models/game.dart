import 'guess_result.dart';

class Game {
  final String answer;
  final List<GuessResult> guessHistory;
  final String currentInput;
  final bool isWon;
  final int attemptCount;

  Game({
    required this.answer,
    List<GuessResult>? guessHistory,
    String currentInput = '',
    this.isWon = false,
    int? attemptCount,
  }) : guessHistory = guessHistory ?? [],
       currentInput = currentInput,
       attemptCount = attemptCount ?? (guessHistory?.length ?? 0);

  Game copyWith({
    String? answer,
    List<GuessResult>? guessHistory,
    String? currentInput,
    bool? isWon,
    int? attemptCount,
  }) {
    return Game(
      answer: answer ?? this.answer,
      guessHistory: guessHistory ?? this.guessHistory,
      currentInput: currentInput ?? this.currentInput,
      isWon: isWon ?? this.isWon,
      attemptCount: attemptCount ?? this.attemptCount,
    );
  }

  bool get isInputFull => currentInput.length == 4;
  bool get isInputEmpty => currentInput.isEmpty;
}
