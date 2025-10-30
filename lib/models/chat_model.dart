// Chat Model
class ChatModel {
  final String chatId;
  final String contactId;
  final String contactName;
  final String? contactProfilePic;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isGroup;
  final bool isMuted;
  final bool isPinned;
  final String? lastMessageSenderId;

  ChatModel({
    required this.chatId,
    required this.contactId,
    required this.contactName,
    this.contactProfilePic,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isGroup = false,
    this.isMuted = false,
    this.isPinned = false,
    this.lastMessageSenderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'contactId': contactId,
      'contactName': contactName,
      'contactProfilePic': contactProfilePic,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'unreadCount': unreadCount,
      'isGroup': isGroup,
      'isMuted': isMuted,
      'isPinned': isPinned,
      'lastMessageSenderId': lastMessageSenderId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      contactId: map['contactId'] ?? '',
      contactName: map['contactName'] ?? '',
      contactProfilePic: map['contactProfilePic'],
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
        map['lastMessageTime'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      unreadCount: map['unreadCount'] ?? 0,
      isGroup: map['isGroup'] ?? false,
      isMuted: map['isMuted'] ?? false,
      isPinned: map['isPinned'] ?? false,
      lastMessageSenderId: map['lastMessageSenderId'],
    );
  }
}
