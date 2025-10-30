// Story Service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Get stories stream
  Stream<List<Map<String, dynamic>>> getStoriesStream() {
    return _firestore
        .collection('stories')
        .where(
          'createdAt',
          isGreaterThan: DateTime.now().subtract(const Duration(hours: 24)),
        )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  // Add a story
  Future<void> addStory({
    required String mediaUrl,
    required String type,
    String? caption,
  }) async {
    if (currentUserId == null) return;

    final storyId = _firestore.collection('stories').doc().id;

    await _firestore.collection('stories').doc(storyId).set({
      'storyId': storyId,
      'userId': currentUserId,
      'mediaUrl': mediaUrl,
      'type': type,
      'caption': caption,
      'timestamp': FieldValue.serverTimestamp(),
      'viewedBy': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Mark story as viewed
  Future<void> markStoryAsViewed(String storyId) async {
    if (currentUserId == null) return;

    await _firestore.collection('stories').doc(storyId).update({
      'viewedBy': FieldValue.arrayUnion([currentUserId]),
    });
  }

  // Delete story
  Future<void> deleteStory(String storyId) async {
    await _firestore.collection('stories').doc(storyId).delete();
  }
}
