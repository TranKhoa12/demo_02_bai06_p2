import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message_bubble.dart';

// Bước 2: Đổ dữ liệu danh sách tin nhắn từ Firestore theo giáo trình.
class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
            chatDocs[index]['userId'], // UID của người gửi
            (chatDocs[index]['createdAt'] as Timestamp)
                .toDate(), // Thời gian gửi (Firestore lưu trữ dưới dạng Timestamp)
          ),
        );
      },
    );
  }
}
