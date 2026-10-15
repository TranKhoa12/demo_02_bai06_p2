import 'package:flutter/material.dart';

// Bước 1: Tạo MessageBubble theo giáo trình.
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;
  final DateTime timestamp; // Thời gian gửi tin nhắn

  const MessageBubble(
    this.message,
    this.isMe,
    this.userId,
    this.timestamp, {
    super.key,
  });

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';

    // Giữ nguyên cách định dạng trong ảnh giáo trình (ví dụ 14:34 PM).
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTimestamp(timestamp);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[300] : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 250, // Tăng kích thước để hiển thị thêm thông tin
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // UID của người gửi tin nhắn
              Text(
                userId, // Hiển thị UID của người gửi
                style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              // Nội dung tin nhắn
              Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
              const SizedBox(height: 8),
              // Thời gian gửi tin nhắn
              Text(
                formattedTime, // Hiển thị thời gian
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
