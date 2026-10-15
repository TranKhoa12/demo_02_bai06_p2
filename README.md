# Chat Firestore — đồng bộ với ảnh giáo trình

## Thứ tự đối chiếu ảnh

1. `lib/widgets/message_bubble.dart`: `MessageBubble extends StatelessWidget`,
   bốn thuộc tính `message`, `isMe`, `userId`, `timestamp`; constructor truyền
   tham số theo thứ tự; hàm `_formatTimestamp(DateTime timestamp)` và giao diện
   `Row → Container → Column` đúng cấu trúc ảnh. Bong bóng rộng 250.
2. `lib/widgets/messages.dart`: `Messages extends StatelessWidget`,
   `StreamBuilder`, biến `chatSnapshot`, `chatDocs`, truy vấn collection `chat`
   theo `createdAt` giảm dần, `ListView.builder(reverse: true)` như ảnh.
3. `lib/screens/chat_screen.dart`: tiêu đề Chat Firestore, UID,
   `DropdownButton` đăng xuất, `Messages()`, `_controller`, `_enteredMessage`,
   ô nhập `labelText` và nút gửi như ảnh.
4. `lib/main.dart`: `MyApp`, theme `primarySwatch: Colors.blue`,
   `authStateChanges()` và nút đăng nhập ẩn danh ngay trong `home` như ảnh.

Code giữ cách hiển thị thời gian của giáo trình, ví dụ **14:34 PM**.

Các ảnh chưa có phần ChatScreen {1} (khai báo state và hàm gửi tin), nên phần
này được bổ sung tối thiểu: `_controller`, `_enteredMessage`, `_sendMessage()`
ghi ba trường `text`, `userId`, `createdAt` (dùng `Timestamp.now()`).
Thêm `dispose()` giải phóng controller. Phần khởi tạo Firebase giữ cấu hình
hiện có và gọi `WidgetsFlutterBinding.ensureInitialized()` trước khi khởi tạo.

## Firebase và chạy thử

- Bật Authentication → Sign-in method → Anonymous trong Firebase Console.
- Tạo Cloud Firestore database mặc định nếu chưa có.
- Áp dụng `firestore.rules` trong Firestore → Rules → Publish. File cục bộ chưa
  tự được triển khai. Nếu có collection khác, ghép phần rules cho `chat` vào
  rules hiện tại để giữ quyền của các collection đó.
- Mỗi tin trong `chat` có `text` (string), `userId` (string), `createdAt`
  (timestamp). Collection được tạo khi gửi tin đầu tiên.

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Dùng hai thiết bị hoặc hai phiên trình duyệt độc lập, đăng nhập để có hai UID,
người thứ nhất gửi “Xin chào”, “HUTECH”, người thứ hai gửi “IT”.
Đối chiếu tin xanh bên phải và tin trắng bên trái theo ảnh.

Widget test kiểm tra cách hiển thị và căn lề, không kết nối Firebase.
Bản này giữ logic đơn giản như ảnh; khi đọc Firestore lỗi hoặc dữ liệu thiếu
`createdAt`, code trong ảnh chưa có nhánh xử lý riêng cho các trường hợp đó.
