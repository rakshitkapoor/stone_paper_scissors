import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/widgets/custom_text.dart';
import 'package:stone_paper_scissors/widgets/player_avatar.dart';
import 'package:stone_paper_scissors/socket_manager.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game-room';
  const GameScreen(
      {super.key,
      required this.roomId,
      required this.player1,
      required this.player2});
  final String roomId;
  final String player1;
  final String player2;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String? _selectedButton;
  int score1 = 0;
  int score2 = 0;

  int _playerScore = 0;
  int _opponentScore = 0;
  String _winner = '';

  @override
  void initState() {
    super.initState();
    SocketManager().on('move', _handleMove);
    SocketManager().on('winner', _handleWinner);
    print(widget.player1);
  }

  void _handleMove(dynamic data) {
    setState(() {
      // Update the game state based on the move data
    });
  }

  void _handleWinner(dynamic data) {
    setState(() {
      _winner = data['winner'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Socket ID :${SocketManager().getId()}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Code: ${widget.roomId}"),
        backgroundColor: bg,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayerAvatar(
                    name: "${widget.player1}", backgroundColor: Colors.blue),
                PlayerAvatar(
                    name: "${widget.player2}", backgroundColor: Colors.green),
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
                text: "${score1}",
                fontSize: screenSize.height * 0.1,
              ),
              CustomText(
                shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
                text: ":",
                fontSize: screenSize.height * 0.1,
              ),
              CustomText(
                shadows: const [Shadow(color: Colors.green, blurRadius: 40)],
                text: "$score2",
                fontSize: screenSize.height * 0.1,
              )
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButton = 'Stone';
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                _selectedButton == 'Stone'
                    ? Color.fromARGB(255, 10, 71, 42)
                    : Colors.transparent,
              ),
              overlayColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 10, 71, 42)),
              elevation: MaterialStatePropertyAll(5),
              fixedSize: MaterialStatePropertyAll(
                  Size(screenSize.width * 0.7, screenSize.height * 0.08)),
            ),
            child: CustomText(
              shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
              text: "Stone",
              fontSize: screenSize.height * 0.03,
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButton = 'Paper';
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                _selectedButton == 'Paper'
                    ? Color.fromARGB(255, 143, 67, 39)
                    : Colors.transparent,
              ),
              overlayColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 143, 67, 39)),
              fixedSize: MaterialStatePropertyAll(
                  Size(screenSize.width * 0.7, screenSize.height * 0.08)),
            ),
            child: CustomText(
              shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
              text: "Paper",
              fontSize: screenSize.height * 0.03,
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButton = 'Scissors';
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                _selectedButton == 'Scissors'
                    ? Color.fromARGB(255, 66, 10, 71)
                    : Colors.transparent,
              ),
              overlayColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 66, 10, 71)),
              fixedSize: MaterialStatePropertyAll(
                  Size(screenSize.width * 0.7, screenSize.height * 0.08)),
            ),
            child: CustomText(
              shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
              text: "Scissors",
              fontSize: screenSize.height * 0.03,
            ),
          )
        ],
      ),
    );
  }
}
