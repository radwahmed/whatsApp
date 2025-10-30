import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String? contactProfilePic;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.contactName,
    this.contactProfilePic,
    this.isOnline = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  late AnimationController _sendButtonController;
  late Animation<double> _sendButtonScale;

  // Sample messages
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey! How are you?',
      'isSent': false,
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
    },
    {
      'text': 'I\'m doing great! Thanks for asking 😊',
      'isSent': true,
      'time': DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
      'isRead': true,
    },
    {
      'text': 'How about you?',
      'isSent': true,
      'time': DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
      'isRead': true,
    },
    {
      'text': 'Pretty good! Just working on a new project',
      'isSent': false,
      'time': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      'isRead': true,
    },
    {
      'text': 'That sounds interesting! What kind of project?',
      'isSent': true,
      'time': DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
      'isRead': true,
    },
    {
      'text': 'Building a Flutter app. It\'s been really fun so far!',
      'isSent': false,
      'time': DateTime.now().subtract(const Duration(minutes: 45)),
      'isRead': true,
    },
    {
      'text': 'Awesome! Let me know if you need any help',
      'isSent': true,
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'isRead': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _sendButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _sendButtonScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _sendButtonController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _sendButtonController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isSent': true,
        'time': DateTime.now(),
        'isRead': false,
      });
    });

    _messageController.clear();
    setState(() {
      _isTyping = false;
    });

    // Animate scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Show sent animation
    _showMessageSentAnimation();
  }

  void _showMessageSentAnimation() {
    _sendButtonController.forward().then((_) {
      _sendButtonController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: InkWell(
          onTap: () {
            // Navigate to contact info
          },
          child: Row(
            children: [
              Hero(
                tag: 'profile_${widget.contactName}',
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.contactProfilePic != null
                      ? NetworkImage(widget.contactProfilePic!)
                      : null,
                  child: widget.contactProfilePic == null
                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contactName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        if (widget.isOnline)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF25D366),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          widget.isOnline
                              ? 'online'
                              : 'last seen today at 12:30 PM',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: isDark
                                ? Colors.white70
                                : Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view_contact',
                child: Text('View contact'),
              ),
              const PopupMenuItem(
                value: 'media',
                child: Text('Media, links, and docs'),
              ),
              const PopupMenuItem(value: 'search', child: Text('Search')),
              const PopupMenuItem(
                value: 'mute',
                child: Text('Mute notifications'),
              ),
              const PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
              const PopupMenuItem(value: 'more', child: Text('More')),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0B141A) : const Color(0xFFEFE7DD),
          // Background pattern overlay
          image: DecorationImage(
            image: AssetImage(
              isDark ? 'assets/chat_bg_dark.png' : 'assets/chat_bg_light.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.3,
            onError: (exception, stackTrace) {
              // Fallback if images not found
            },
          ),
        ),
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showTime =
                      index == 0 ||
                      _messages[index - 1]['time']
                              .difference(message['time'])
                              .inMinutes
                              .abs() >
                          30;

                  return Column(
                    children: [
                      if (showTime)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1F2C34)
                                  : Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _formatMessageDate(message['time']),
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ),
                        ),
                      AnimatedMessageBubble(
                        index: index,
                        text: message['text'],
                        isSent: message['isSent'],
                        time: message['time'],
                        isRead: message['isRead'],
                      ),
                    ],
                  );
                },
              ),
            ),

            // Message input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1F2C34) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Message',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              maxLines: null,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (text) {
                                setState(() {
                                  _isTyping = text.isNotEmpty;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.attach_file,
                              color: theme.iconTheme.color,
                            ),
                            onPressed: () {},
                          ),
                          if (!_isTyping)
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: theme.iconTheme.color,
                              ),
                              onPressed: () {},
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  ScaleTransition(
                    scale: _sendButtonScale,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF25D366),
                      radius: 24,
                      child: IconButton(
                        icon: Icon(
                          _isTyping ? Icons.send : Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: _isTyping ? _sendMessage : () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}

// Animated Message Bubble with entrance animation
class AnimatedMessageBubble extends StatefulWidget {
  final int index;
  final String text;
  final bool isSent;
  final DateTime time;
  final bool isRead;

  const AnimatedMessageBubble({
    super.key,
    required this.index,
    required this.text,
    required this.isSent,
    required this.time,
    required this.isRead,
  });

  @override
  State<AnimatedMessageBubble> createState() => _AnimatedMessageBubbleState();
}

class _AnimatedMessageBubbleState extends State<AnimatedMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    final offset = widget.isSent ? const Offset(0.3, 0) : const Offset(-0.3, 0);

    _slideAnimation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: MessageBubble(
          text: widget.text,
          isSent: widget.isSent,
          time: widget.time,
          isRead: widget.isRead,
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSent;
  final DateTime time;
  final bool isRead;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isSent,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSent
              ? (isDark ? const Color(0xFF005C4B) : const Color(0xFFD9FDD3))
              : (isDark ? const Color(0xFF202C33) : Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: Radius.circular(isSent ? 8 : 0),
            bottomRight: Radius.circular(isSent ? 0 : 8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(time),
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
                if (isSent) ...[
                  const SizedBox(width: 4),
                  Icon(
                    isRead ? Icons.done_all : Icons.done,
                    size: 16,
                    color: isRead
                        ? const Color(0xFF53BDEB)
                        : theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
