import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:typed_data';
import 'dart:convert';

class TextMessageScreen extends StatefulWidget {
  @override
  _TextMessageScreenState createState() => _TextMessageScreenState();
}

class _TextMessageScreenState extends State<TextMessageScreen> {
  final TextEditingController _controller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.0.35:8080'),
  );
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      setState(() {
        String message;
        if (data is Uint8List) {
          message = utf8.decode(data);
        } else if (data is String) {
          message = data;
        } else {
          // If the data is neither Uint8List nor String, handle it accordingly
          message = 'Error: Unexpected data type';
        }
        messages.add({"text": message, "isSent": false});
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Messaging App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["isSent"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: message["isSent"] ? Colors.blue[900] : Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["text"],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Send a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = _controller.text;
      setState(() {
        // Marking this message as sent by the current user
        messages.add({"text": message, "isSent": true});
      });
      channel.sink.add(message);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
