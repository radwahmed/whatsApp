// Message Model
class MessageModel {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String text;
  final MessageType type;
  final DateTime sentTime;
  final bool isSeen;
  final bool isDelivered;
  final String? replyToMessageId;
  final String? mediaUrl;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.sentTime,
    this.isSeen = false,
    this.isDelivered = false,
    this.replyToMessageId,
    this.mediaUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type.toString(),
      'sentTime': sentTime.millisecondsSinceEpoch,
      'isSeen': isSeen,
      'isDelivered': isDelivered,
      'replyToMessageId': replyToMessageId,
      'mediaUrl': mediaUrl,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => MessageType.text,
      ),
      sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime']),
      isSeen: map['isSeen'] ?? false,
      isDelivered: map['isDelivered'] ?? false,
      replyToMessageId: map['replyToMessageId'],
      mediaUrl: map['mediaUrl'],
    );
  }
}

enum MessageType { text, image, video, audio, document }
