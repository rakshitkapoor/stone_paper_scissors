import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/widgets/custom_button.dart';
import 'package:stone_paper_scissors/widgets/custom_text.dart';
import 'package:stone_paper_scissors/widgets/custom_textfield.dart';
import 'package:stone_paper_scissors/socket_manager.dart';
import 'package:stone_paper_scissors/Screens/game_screen.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gameId = TextEditingController();
  String _errorMessage="";
  dynamic players;
  String roomId="";
  String player1="";
  String player2="";

  @override
  void initState() {
    super.initState();
    _connectToSocket();
  }

void _connectToSocket() {
  SocketManager().connect();
  SocketManager().on('playerJoined', (data) {
    print('Player joined room: $data');
    setState(() {
      players = data['players'];
      player1 = players[0]['nickname'];
      player2 = players[1]['nickname'];
      roomId = data['roomId'];
      _errorMessage = "";
    });

    // Navigate to the game screen or waiting room after updating the state
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(roomId: roomId, player1: player1, player2: player2),
      ),
    );
  });

  SocketManager().on('error', (error) {
    setState(() {
      _errorMessage = error.toString();
    });
  });
}

  void _joinGame() {
    final String name = _nameController.text.trim();
    final String gameId = _gameId.text.trim();

    if (name.isNotEmpty && gameId.isNotEmpty) {
      SocketManager().emit('joinGame', {'roomId': gameId, 'nickname': name});
      print("player1: $player1");
      print("player2: $player2");
    } else {
      setState(() {
        _errorMessage = 'Please fill in both the nickname and game ID.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
              text: "Join Room",
              fontSize: size.height * 0.11,
            ),
            SizedBox(height: size.height * 0.03),
            CustomTextField(
              controller: _nameController,
              hintText: "Enter Your nickname",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomTextField(
              controller: _gameId,
              hintText: "Enter GameID",
            ),
            if (_errorMessage != null)
              SizedBox(
                height: size.height * 0.01,
              ),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomButton(
              onTap: _joinGame,
              text: "Join",
            ),
          ],
        ),
      ),
    );
  }
}
