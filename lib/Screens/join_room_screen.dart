import 'package:flutter/material.dart';
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
              text: "Join Room",
              fontSize: size.height * 0.11,
            ),
            SizedBox(height: size.height * 0.04),
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
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomButton(onTap: () {}, text: "Join"),
          ],
        ),
      ),
    );
  }
}