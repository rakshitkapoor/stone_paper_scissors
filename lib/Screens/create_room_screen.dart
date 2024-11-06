import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/constants.dart';
import 'package:stone_paper_scissors/widgets/custom_button.dart';
import 'package:stone_paper_scissors/widgets/custom_text.dart';
import 'package:stone_paper_scissors/widgets/custom_textfield.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  late IO.Socket socket;
  String? roomId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    socket.disconnect();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  // Aware !! Sockets below ;)
  void connect() {
    print("entered in connect");
    socket = IO.io(url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connected to socket server');
    });
    
    // catching roomID
    socket.on('roomCreated', (data) {
      setState(() {
        roomId = data;
      });
      print("Room Created with room id: $roomId");
    });
  }

  void createGame(String name) {
    if (name.isNotEmpty) {
      socket.emit('createGame', name); 
      print('Creating game for: $name');
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
