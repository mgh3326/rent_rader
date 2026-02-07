import 'package:flutter/material.dart';
import '../logic/game_engine.dart';
import '../models/game.dart';
import '../models/guess_result.dart';
import '../theme/app_theme.dart';
import '../widgets/number_pad.dart';
import '../widgets/digit_box.dart';
import '../widgets/guess_row.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game _game;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    final answer = GameEngine.generateRandomNumber();
    setState(() {
      _game = Game(answer: answer);
    });
  }

  void _onDigitPressed(String digit) {
    if (_game.isInputFull) return;

    final newInput = _game.currentInput + digit;

    setState(() {
      _game = _game.copyWith(currentInput: newInput);
    });

    if (_game.isInputFull) {
      _submitGuess();
    }
  }

  void _onDeletePressed() {
    if (_game.isInputEmpty) return;

    final newInput = _game.currentInput.substring(
      0,
      _game.currentInput.length - 1,
    );
    setState(() {
      _game = _game.copyWith(currentInput: newInput);
    });
  }

  void _onClearPressed() {
    setState(() {
      _game = _game.copyWith(currentInput: '');
    });
  }

  void _submitGuess() {
    if (!GameEngine.isValidInput(_game.currentInput)) return;

    final guessResult = GuessResult.evaluate(_game.answer, _game.currentInput);

    setState(() {
      _game = _game.copyWith(
        guessHistory: [..._game.guessHistory, guessResult],
        currentInput: '',
        attemptCount: _game.guessHistory.length + 1,
      );
    });

    if (guessResult.strikes == 4) {
      _game = _game.copyWith(isWon: true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(
          context,
          '/result',
          arguments: {'answer': _game.answer, 'attempts': _game.attemptCount},
        );
      });
    }
  }

  Set<String> get _usedDigits => Set<String>.from(_game.currentInput.split(''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_game.attemptCount}번째 시도'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('새 게임'),
                  content: const Text('새 게임을 시작하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _startNewGame();
                      },
                      child: const Text('시작'),
                    ),
                  ],
                ),
              );
            },
            tooltip: '새 게임',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _game.guessHistory.length,
              itemBuilder: (context, index) {
                final result = _game.guessHistory[index];
                return GuessRow(result: result);
              },
            ),
          ),
          _buildInputArea(),
          NumberPad(
            usedDigits: _usedDigits,
            onDigitPressed: _onDigitPressed,
            onDeletePressed: _onDeletePressed,
            onClearPressed: _onClearPressed,
            isInputFull: _game.isInputFull,
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.border, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final hasValue = index < _game.currentInput.length;
          final digit = hasValue ? _game.currentInput[index] : null;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: DigitBox(
              digit: digit,
              state: hasValue ? DigitBoxState.filled : DigitBoxState.empty,
              size: 56,
            ),
          );
        }),
      ),
    );
  }
}
