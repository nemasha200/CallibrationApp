import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:callibration_app/main.dart';

void main() {
  testWidgets('Home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SulecoApp());
    expect(find.text('My Equipment'), findsOneWidget);
  });
}