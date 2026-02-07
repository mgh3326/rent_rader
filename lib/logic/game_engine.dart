import 'dart:math';

class GameEngine {
  static const int digitCount = 4;

  static String generateRandomNumber() {
    final random = Random();
    final availableNumbers = List.generate(10, (i) => i);
    final selectedNumbers = <int>[];

    for (int i = 0; i < digitCount; i++) {
      final index = random.nextInt(availableNumbers.length);
      selectedNumbers.add(availableNumbers.removeAt(index));
    }

    return selectedNumbers.join();
  }

  static bool isValidInput(String input) {
    if (input.length != digitCount) return false;

    final hasDuplicates = input.split('').toSet().length != input.length;
    return !hasDuplicates;
  }

  static ({int strikes, int balls}) evaluateGuess(String answer, String guess) {
    int strikes = 0;
    int balls = 0;

    for (int i = 0; i < digitCount; i++) {
      if (answer[i] == guess[i]) {
        strikes++;
      } else if (answer.contains(guess[i])) {
        balls++;
      }
    }

    return (strikes: strikes, balls: balls);
  }

  static bool isCorrect(int strikes) {
    return strikes == digitCount;
  }

  static bool isOut(int strikes, int balls) {
    return strikes == 0 && balls == 0;
  }
}
