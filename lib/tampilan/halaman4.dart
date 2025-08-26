import 'package:flutter/material.dart';
import 'package:widget/tampilan/halaman2.dart';
import 'halaman5.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  
  HomeScreen({required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> chatList = [
    {
      'name': 'Sayang',
      'lastMessage': 'Jadi Kerumah?',
      'time': '2:30 PM',
      'avatar': Icons.person,
      'unreadCount': 2,
      'online': true,
    },
    {
      'name': 'Pak Budi',
      'lastMessage': 'Iya Gak Paapa Besok Aja',
      'time': '1:15 PM',
      'avatar': Icons.person,
      'unreadCount': 0,
      'online': false,
    },
    {
      'name': 'Family Group',
      'lastMessage': 'Mom: Udah ditf 200jt yahh',
      'time': '12:45 PM',
      'avatar': Icons.group,
      'unreadCount': 5,
      'online': false,
    },
  ];

  final List<Map<String, dynamic>> statusList = [
    {'name': 'My Status', 'time': 'Tap to add status', 'avatar': Icons.add_circle, 'isMyStatus': true},
    {'name': 'Sayang', 'time': '2 hours ago', 'avatar': Icons.person, 'isMyStatus': false},
    {'name': 'Ayah', 'time': '5 hours ago', 'avatar': Icons.person, 'isMyStatus': false},
    {'name': 'Pak Budi', 'time': '1 day ago', 'avatar': Icons.person, 'isMyStatus': false},
  ];

  final List<Map<String, dynamic>> callsList = [
    {'name': 'Sayang', 'time': 'Today, 2:30 PM', 'type': 'incoming', 'isVideo': false},
    {'name': 'Sayang', 'time': 'Yesterday, 1:10 PM', 'type': 'incoming', 'isVideo': false},
    {'name': 'Sayang', 'time': 'Yesterday, 5:20 AM', 'type': 'incoming', 'isVideo': false},
    {'name': 'Pak Wilson', 'time': 'Today, 1:15 PM', 'type': 'outgoing', 'isVideo': true},
    {'name': 'Ayah', 'time': 'Yesterday, 8:20 PM', 'type': 'missed', 'isVideo': false},
    {'name': 'Ayah', 'time': 'Yesterday, 3:45 PM', 'type': 'outgoing', 'isVideo': false},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Vikontak',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Chats'),
            Tab(text: 'Status'),
            Tab(text: 'Calls'),
            Tab(text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatsTab(),
          _buildStatusTab(),
          _buildCallsTab(),
          _buildSettingsTab(),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: () {
                _showNewChatDialog();
              },
              backgroundColor: Color(0xFF725CAD),
              child: Icon(Icons.chat, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildStatusTab() {
    return ListView.builder(
      itemCount: statusList.length,
      itemBuilder: (context, index) {
        final status = statusList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: status['isMyStatus'] ? Color(0xFF725CAD) : Colors.grey,
            child: Icon(
              status['avatar'],
              color: Colors.white,
            ),
          ),
          title: Text(
            status['name'],
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(status['time']),
          onTap: () {
            if (!status['isMyStatus']) {
              _showStatusView(status['name']);
            }
          },
        );
      },
    );
  }

  Widget _buildChatsTab() {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final chat = chatList[index];
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(
                  chat['avatar'],
                  color: Colors.grey[600],
                ),
              ),
              if (chat['online'])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 134, 9, 145),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            chat['name'],
            style: TextStyle(
              fontWeight: chat['unreadCount'] > 0 ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          subtitle: Text(
            chat['lastMessage'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: chat['unreadCount'] > 0 ? Colors.black87 : Colors.grey[600],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat['time'],
                style: TextStyle(
                  color: chat['unreadCount'] > 0 ? Color(0xFF725CAD) : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              if (chat['unreadCount'] > 0) ...[
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    chat['unreadCount'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                  chatName: chat['name'],
                  isOnline: chat['online'],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCallsTab() {
    return ListView.builder(
      itemCount: callsList.length,
      itemBuilder: (context, index) {
        final call = callsList[index];
        IconData callIcon;
        Color iconColor;

        switch (call['type']) {
          case 'incoming':
            callIcon = Icons.call_received;
            iconColor = const Color.fromARGB(255, 134, 9, 145);
            break;
          case 'outgoing':
            callIcon = Icons.call_made;
            iconColor = Colors.grey[600]!;
            break;
          case 'missed':
            callIcon = Icons.call_received;
            iconColor = Colors.red;
            break;
          default:
            callIcon = Icons.call;
            iconColor = Colors.grey[600]!;
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
            ),
          ),
          title: Text(
            call['name'],
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Row(
            children: [
              Icon(callIcon, size: 16, color: iconColor),
              SizedBox(width: 4),
              Text(call['time']),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              call['isVideo'] ? Icons.videocam : Icons.call,
              color: Color(0xFF725CAD),
            ),
            onPressed: () {
              _makeCall(call['name'], call['isVideo']);
            },
          ),
        );
      },
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF725CAD),
                child: Text(
                  widget.userName.substring(0, 0).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Im Never Forget You',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        _buildSettingsItem(Icons.account_circle, 'Account', 'Privacy, security, change number'),
        _buildSettingsItem(Icons.chat, 'Chats', 'Backup, history, wallpaper'),
        _buildSettingsItem(Icons.notifications, 'Notifications', 'Message, group & call tones'),
        _buildSettingsItem(Icons.data_usage, 'Storage and data', 'Network usage, auto-download'),
        _buildSettingsItem(Icons.help, 'Help', 'Help centre, contact us, privacy policy'),
        _buildSettingsItem(Icons.people, 'Invite a friend', ''),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            _showLogoutDialog();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title tapped')),
        );
      },
    );
  }

  void _showNewChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Chat'),
        content: Text('Choose a contact to start a new chat'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kamu Belum Punya Nomer Terbaru')),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showStatusView(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$name\'s Status'),
        content: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility_off, size: 100, color: Colors.grey),
                Text('Anda Menggunakan Web. Tidak Diizinkan'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _makeCall(String name, bool isVideo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${isVideo ? 'Video' : 'Voice'} calling $name...'),
        backgroundColor: Color(0xFF725CAD),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Anda Yakin Ingin Keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen()),
                (route) => false,
              );
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}