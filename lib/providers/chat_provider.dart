import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<ChatModel> _chats = [];
  List<MessageModel> _currentChatMessages = [];
  String? _currentChatId;
  final bool _isLoading = false;
  bool _isTyping = false;
  UserModel? _currentChatUser;

  List<ChatModel> get chats => _chats;
  List<MessageModel> get currentChatMessages => _currentChatMessages;
  String? get currentChatId => _currentChatId;
  bool get isLoading => _isLoading;
  bool get isTyping => _isTyping;
  UserModel? get currentChatUser => _currentChatUser;

  String? get currentUserId => _auth.currentUser?.uid;

  // Initialize chat list stream
  void initializeChats() {
    _chatService.getChatsStream().listen((chats) {
      _chats = chats;
      notifyListeners();
    });
  }

  // Set current chat and load messages
  void setCurrentChat(String chatId, UserModel user) {
    _currentChatId = chatId;
    _currentChatUser = user;
    _loadMessages(chatId);
    notifyListeners();
  }

  // Load messages for current chat
  void _loadMessages(String chatId) {
    _chatService.getMessagesStream(chatId).listen((messages) {
      _currentChatMessages = messages;
      notifyListeners();

      // Mark messages as read
      if (messages.isNotEmpty) {
        _chatService.markMessagesAsRead(chatId);
      }
    });
  }

  // Send text message
  Future<void> sendMessage({
    required String receiverId,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    try {
      await _chatService.sendMessage(
        receiverId: receiverId,
        text: text,
        type: MessageType.text,
      );
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  // Send media message
  Future<void> sendMediaMessage({
    required String receiverId,
    required String mediaUrl,
    required MessageType type,
    String? caption,
  }) async {
    try {
      await _chatService.sendMessage(
        receiverId: receiverId,
        text: caption ?? '',
        type: type,
        mediaUrl: mediaUrl,
      );
    } catch (e) {
      print('Error sending media message: $e');
      rethrow;
    }
  }

  // Delete message
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      await _chatService.deleteMessage(chatId, messageId);
    } catch (e) {
      print('Error deleting message: $e');
      rethrow;
    }
  }

  // Set typing status
  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  // Search users
  Future<List<UserModel>> searchUsers(String query) async {
    if (query.isEmpty) return [];

    try {
      return await _chatService.searchUsers(query);
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }

  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      return await _chatService.getUserById(userId);
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Clear current chat
  void clearCurrentChat() {
    _currentChatId = null;
    _currentChatUser = null;
    _currentChatMessages = [];
    notifyListeners();
  }

  // Get unread message count
  int getUnreadCount() {
    int count = 0;
    for (var chat in _chats) {
      count += chat.unreadCount;
    }
    return count;
  }

  // Pin/Unpin chat
  Future<void> togglePinChat(String chatId, bool isPinned) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'isPinned': !isPinned,
      });
    } catch (e) {
      print('Error toggling pin: $e');
    }
  }

  // Mute/Unmute chat
  Future<void> toggleMuteChat(String chatId, bool isMuted) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'isMuted': !isMuted,
      });
    } catch (e) {
      print('Error toggling mute: $e');
    }
  }

  // Delete chat
  Future<void> deleteChat(String chatId) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).delete();

      _chats.removeWhere((chat) => chat.chatId == chatId);
      notifyListeners();
    } catch (e) {
      print('Error deleting chat: $e');
    }
  }

  // Archive chat
  Future<void> archiveChat(String chatId) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'isArchived': true,
      });
    } catch (e) {
      print('Error archiving chat: $e');
    }
  }

  @override
  void dispose() {
    _chats.clear();
    _currentChatMessages.clear();
    super.dispose();
  }
}
