import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:whats_app/screens/chat/chat_screen.dart';
import 'package:whats_app/providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabScaleAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _fabAnimationController.reset();
        _fabAnimationController.forward();
      }
    });

    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'settings') {
                _showThemeDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'new_group', child: Text('New group')),
              const PopupMenuItem(
                value: 'new_broadcast',
                child: Text('New broadcast'),
              ),
              const PopupMenuItem(
                value: 'linked_devices',
                child: Text('Linked devices'),
              ),
              const PopupMenuItem(
                value: 'starred',
                child: Text('Starred messages'),
              ),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.group, size: 22)),
            Tab(text: 'Chats'),
            Tab(text: 'Updates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCommunitiesTab(),
          _buildChatsTab(),
          _buildUpdatesTab(),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnimation,
        child: _buildFloatingActionButton(isDark),
      ),
    );
  }

  Widget _buildFloatingActionButton(bool isDark) {
    if (_tabController.index == 1) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      );
    } else if (_tabController.index == 2) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'edit_status',
            onPressed: () {},
            backgroundColor: isDark
                ? const Color(0xFF1F2C34)
                : Colors.grey[200],
            foregroundColor: isDark ? Colors.white : Colors.black,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'camera_status',
            onPressed: () {},
            child: const Icon(Icons.camera_alt),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  void _showThemeDialog(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunitiesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Stay connected with a community',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsTab() {
    // Sample chat data
    final chats = [
      {
        'name': 'John Doe',
        'message': 'Hey! How are you doing?',
        'time': DateTime.now().subtract(const Duration(minutes: 5)),
        'unread': 2,
        'profilePic': null,
        'isPinned': true,
      },
      {
        'name': 'Sarah Wilson',
        'message': 'See you tomorrow! 👋',
        'time': DateTime.now().subtract(const Duration(hours: 1)),
        'unread': 0,
        'profilePic': null,
        'isPinned': false,
      },
      {
        'name': 'Family Group',
        'message': 'Mom: Don\'t forget dinner tonight',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'unread': 5,
        'profilePic': null,
        'isPinned': false,
        'isGroup': true,
      },
      {
        'name': 'Alex Johnson',
        'message': 'That sounds great!',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'unread': 0,
        'profilePic': null,
        'isPinned': false,
      },
      {
        'name': 'Work Team',
        'message': 'Mike: Meeting at 3 PM',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'unread': 12,
        'profilePic': null,
        'isPinned': false,
        'isGroup': true,
      },
    ];

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return AnimatedChatListTile(
          index: index,
          name: chat['name'] as String,
          message: chat['message'] as String,
          time: chat['time'] as DateTime,
          unreadCount: chat['unread'] as int,
          profilePic: chat['profilePic'] as String?,
          isPinned: chat['isPinned'] as bool,
          isGroup: chat['isGroup'] as bool? ?? false,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ChatScreen(
                    contactName: chat['name'] as String,
                    contactProfilePic: null,
                    isOnline: false,
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUpdatesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My Status
          ListTile(
            leading: Stack(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF25D366),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              'My status',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Tap to add status update',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {},
          ),
          const Divider(),

          // Recent updates section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Recent updates',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          // Sample status updates
          ...List.generate(
            5,
            (index) => StatusListTile(
              name: 'Contact ${index + 1}',
              time: DateTime.now().subtract(Duration(hours: index + 1)),
              hasUnseenStory: index < 2,
              onTap: () {
                // Navigate to story viewer
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Chat List Tile with entrance animation
class AnimatedChatListTile extends StatefulWidget {
  final int index;
  final String name;
  final String message;
  final DateTime time;
  final int unreadCount;
  final String? profilePic;
  final bool isPinned;
  final bool isGroup;
  final VoidCallback onTap;

  const AnimatedChatListTile({
    super.key,
    required this.index,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    this.profilePic,
    this.isPinned = false,
    this.isGroup = false,
    required this.onTap,
  });

  @override
  State<AnimatedChatListTile> createState() => _AnimatedChatListTileState();
}

class _AnimatedChatListTileState extends State<AnimatedChatListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300 + (widget.index * 50)),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
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
        child: ChatListTile(
          name: widget.name,
          message: widget.message,
          time: widget.time,
          unreadCount: widget.unreadCount,
          profilePic: widget.profilePic,
          isPinned: widget.isPinned,
          isGroup: widget.isGroup,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final String name;
  final String message;
  final DateTime time;
  final int unreadCount;
  final String? profilePic;
  final bool isPinned;
  final bool isGroup;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    this.profilePic,
    this.isPinned = false,
    this.isGroup = false,
    required this.onTap,
  });

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(time);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(time);
    } else {
      return DateFormat('dd/MM/yyyy').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: isPinned
            ? (isDark ? const Color(0xFF1C2126) : const Color(0xFFF0F2F5))
            : null,
        child: Row(
          children: [
            // Profile picture
            Hero(
              tag: 'profile_$name',
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey,
                backgroundImage: profilePic != null
                    ? NetworkImage(profilePic!)
                    : null,
                child: profilePic == null
                    ? Icon(
                        isGroup ? Icons.group : Icons.person,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),

            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (isPinned)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.push_pin,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            Flexible(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _formatTime(time),
                        style: TextStyle(
                          fontSize: 13,
                          color: unreadCount > 0
                              ? const Color(0xFF25D366)
                              : theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF25D366),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(minWidth: 20),
                          child: Center(
                            child: Text(
                              unreadCount > 99 ? '99+' : unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
    );
  }
}

class StatusListTile extends StatelessWidget {
  final String name;
  final DateTime time;
  final bool hasUnseenStory;
  final VoidCallback onTap;

  const StatusListTile({
    super.key,
    required this.name,
    required this.time,
    required this.hasUnseenStory,
    required this.onTap,
  });

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: hasUnseenStory ? const Color(0xFF25D366) : Colors.grey,
            width: 2.5,
          ),
        ),
        child: const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        _formatTime(time),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }
}
