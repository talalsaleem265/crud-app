import 'package:flutter_test/flutter_test.dart';
import 'package:sqlitecrudapp/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);

  });
}