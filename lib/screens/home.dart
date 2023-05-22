
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOScreen extends StatefulWidget {
  @override
  _SocketIOScreenState createState() => _SocketIOScreenState();
}

class _SocketIOScreenState extends State<SocketIOScreen> {
  final TextEditingController _textController = TextEditingController();
  String _status = '';
  IO.Socket? socket;

  void _connectToServer() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.onConnect((_) {
      setState(() {
        _status = 'Connected to server';
      });
      print('connected to server');
    });

    socket!.onDisconnect((_) {
      setState(() {
        _status = 'Disconnected from server';
      });
      print('disconnected from server');
    });

    socket!.on('message', (data) {
      print('received message: $data');
    });

    socket!.connect();
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      socket?.emit('chat_message', _textController.text);
      _textController.clear();
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(_status),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter message'),
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Send'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _connectToServer,
        tooltip: 'Connect',
        child: const Icon(Icons.connect_without_contact),
      ),
    );
  }
}
