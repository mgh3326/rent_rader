import '../logic/game_engine.dart';

class GuessResult {
  final String guess;
  final int strikes;
  final int balls;
  final bool isOut;

  GuessResult({required this.guess, required this.strikes, required this.balls})
    : isOut = strikes == 0 && balls == 0;

  factory GuessResult.evaluate(String answer, String guess) {
    final result = GameEngine.evaluateGuess(answer, guess);
    return GuessResult(
      guess: guess,
      strikes: result.strikes,
      balls: result.balls,
    );
  }

  Map<String, dynamic> toJson() {
    return {'guess': guess, 'strikes': strikes, 'balls': balls, 'isOut': isOut};
  }

  factory GuessResult.fromJson(Map<String, dynamic> json) {
    return GuessResult(
      guess: json['guess'] as String,
      strikes: json['strikes'] as int,
      balls: json['balls'] as int,
    );
  }
}
