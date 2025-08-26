import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatName;
  final bool isOnline;

  ChatDetailScreen({required this.chatName, required this.isOnline});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'text': 'Kamu Jangan Capek Capekk Besok Masih Masuk Sekolahh', 'isSender': false, 'time': '1:30 PM'},
    {'text': 'Iyahh Iyahh', 'isSender': true, 'time': '1:31 PM'},
    {'text': 'Awas aja besok sakitt yahh', 'isSender': false, 'time': '1:32 PM'},
    {'text': 'Tidurr istirahattt', 'isSender': false, 'time': '1:32 PM'},
    {'text': 'Iya Sayanggg', 'isSender': true, 'time': '1:37 PM'},
    {'text': 'Jadi Kerumah?', 'isSender': false, 'time': '2:30 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5DDD5),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF725CAD)),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.isOnline ? 'Online' : 'Last seen recently',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => _makeCall(true),
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => _makeCall(false),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(
                  message['text'],
                  message['isSender'],
                  message['time'],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isSender, String time) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isSender ? Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (isSender) ...[
                  SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 16,
                    color: Colors.blue,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  prefixIcon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file, color: Colors.grey),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF725CAD),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                messageController.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'text': messageController.text.trim(),
          'isSender': true,
          'time': _getCurrentTime(),
        });
        messageController.clear();
      });
      
      // Simulate auto reply after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            messages.add({
              'text': _getAutoReply(),
              'isSender': false,
              'time': _getCurrentTime(),
            });
          });
        }
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getAutoReply() {
    final replies = [
      'Bentarr Yah Dipanggil Mama',
      'Kenapa Sayangg',
      'Iyahh Iyahh',
    ];
    return replies[(DateTime.now().millisecondsSinceEpoch) % replies.length];
  }

  void _makeCall(bool isVideo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(isVideo ? Icons.videocam : Icons.call, color: Color(0xFF725CAD)),
            SizedBox(width: 8),
            Text('${isVideo ? 'Video' : 'Voice'} Call'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF725CAD),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              widget.chatName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${isVideo ? 'Video' : 'Voice'} calling...',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.call_end, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 134, 9, 145),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.call, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Call connected with ${widget.chatName}'),
                        backgroundColor: const Color.fromARGB(255, 134, 9, 145),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}