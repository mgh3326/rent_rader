import 'game.dart';

class GameHistory {
  final String id;
  final String answer;
  final int attemptCount;
  final DateTime playedAt;
  final bool isWon;

  GameHistory({
    required this.id,
    required this.answer,
    required this.attemptCount,
    required this.playedAt,
    required this.isWon,
  });

  factory GameHistory.fromGame(Game game) {
    return GameHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      answer: game.answer,
      attemptCount: game.attemptCount,
      playedAt: DateTime.now(),
      isWon: game.isWon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'attemptCount': attemptCount,
      'playedAt': playedAt.toIso8601String(),
      'isWon': isWon,
    };
  }

  factory GameHistory.fromJson(Map<String, dynamic> json) {
    return GameHistory(
      id: json['id'] as String,
      answer: json['answer'] as String,
      attemptCount: json['attemptCount'] as int,
      playedAt: DateTime.parse(json['playedAt'] as String),
      isWon: json['isWon'] as bool,
    );
  }

  String get formattedDate {
    return '${playedAt.year}.${playedAt.month.toString().padLeft(2, '0')}.${playedAt.day.toString().padLeft(2, '0')}';
  }
}
