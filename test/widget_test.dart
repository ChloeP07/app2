import 'package:flutter_test/flutter_test.dart';

import 'package:app2/main.dart';

void main() {
  testWidgets('shows the app2 placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(const App2());

    expect(find.text('app2'), findsOneWidget);
  });
}
