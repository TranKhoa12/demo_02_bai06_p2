import 'package:demo_02_bai06_p2/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hiển thị tin của mình theo định dạng giáo trình', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            'HUTECH',
            true,
            'user-1',
            DateTime(2026, 10, 15, 14, 34),
          ),
        ),
      ),
    );
    expect(find.text('HUTECH'), findsOneWidget);
    expect(find.text('user-1'), findsOneWidget);
    expect(find.text('14:34 PM'), findsOneWidget);
    expect(
      tester.widget<Row>(find.byType(Row)).mainAxisAlignment,
      MainAxisAlignment.end,
    );
  });

  testWidgets('Tin người khác căn trái', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            'IT',
            false,
            'user-2',
            DateTime(2026, 10, 15, 14, 35),
          ),
        ),
      ),
    );
    expect(find.text('14:35 PM'), findsOneWidget);
    expect(
      tester.widget<Row>(find.byType(Row)).mainAxisAlignment,
      MainAxisAlignment.start,
    );
  });
}
