import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'constants.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket _socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void connect() {
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.onConnect((_) {
      print('Connected to socket server');
    });
  }
  String? getId(){
    return _socket.id;
  }

  void disconnect() {
    _socket.disconnect();
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }
}