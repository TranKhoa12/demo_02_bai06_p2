import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/chat_screen.dart';

Future<void> main() async {
  // Khởi tạo Firebase bằng cấu hình sẵn có của dự án.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// Bước 4: Tạo chức năng đăng nhập ẩn danh theo giáo trình.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return const ChatScreen();
          }
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                child: const Text('Đăng nhập ẩn danh'),
                onPressed: () async {
                  await FirebaseAuth.instance.signInAnonymously();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
