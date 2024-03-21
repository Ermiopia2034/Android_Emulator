import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TextMessageScreen extends StatefulWidget {
  @override
  _TextMessageScreenState createState() => _TextMessageScreenState();
}

class _TextMessageScreenState extends State<TextMessageScreen> {
  final TextEditingController _controller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://<your_local_network_ip>:8080'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Messaging App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(height: 24),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
