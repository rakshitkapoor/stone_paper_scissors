import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/widgets/custom_button.dart';
import 'package:stone_paper_scissors/widgets/custom_text.dart';
import 'package:stone_paper_scissors/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gameId = TextEditingController();
  late IO.Socket _socket;
  String _errorMessage="";

  @override
  void dispose() {
    // TODO: implement dispose
    _socket.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectToSocket();
  }

  void _connectToSocket() {
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
    _socket.onConnect((_) {
      print('Connected to socket server');
    });

    _socket.on('playerJoined', (data) {
      print('Player joined room: $data');
      setState(() {
        _errorMessage="";
      });
    });

    _socket.on('error', (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    });
  }

  void _joinGame() {
    final String name = _nameController.text.trim();
    final String gameId = _gameId.text.trim();

    if (name.isNotEmpty && gameId.isNotEmpty) {
      _socket.emit('joinGame', {'roomId': gameId, 'nickname': name});
      // Navigate to the game screen or waiting room
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
