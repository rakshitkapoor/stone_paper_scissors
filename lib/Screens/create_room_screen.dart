import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/Screens/game_screen.dart';
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/widgets/custom_button.dart';
import 'package:stone_paper_scissors/widgets/custom_text.dart';
import 'package:stone_paper_scissors/widgets/custom_textfield.dart';
import 'package:stone_paper_scissors/socket_manager.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? roomId;

  @override
  void initState() {
    super.initState();
    SocketManager().connect();
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }

 

  void createGame(String name) {
    if (name.isNotEmpty) {
      SocketManager().emit('createGame', name);
      joinRoom(context);
    } else {
      print('Nickname is required');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.height * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              shadows: const [Shadow(color: Colors.blue, blurRadius: 40)],
              text: "Create Room",
              fontSize: size.height * 0.11,
            ),
            SizedBox(height: size.height * 0.03),
            CustomTextField(
              controller: _nameController,
              hintText: "Enter Your nickname",
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            CustomButton(
                onTap: () {
                  // add function
                  createGame(_nameController.text);
                  print(_nameController.text.toString());
                },
                text: "Create"),
          ],
        ),
      ),
    );
  }
}
