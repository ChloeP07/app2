import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app2/main.dart';

void main() {
  testWidgets('shows the welcome screen actions', (WidgetTester tester) async {
    await tester.pumpWidget(const App2());

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('making your food choices easier'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byKey(const Key('get-started-button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('get-started-button')));
    await tester.pumpAndSettle();

    expect(find.text('What sounds good?'), findsOneWidget);
    expect(find.text('Mexican'), findsOneWidget);
    expect(find.text('Soul Food'), findsOneWidget);
  });
}
