import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/src/button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

void main() {
  testWidgets('Check on tap works', (WidgetTester tester) async {
    var buttonKey = UniqueKey();

    var testVal = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            key: buttonKey,
            onPressed: () {
              testVal = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(buttonKey));
    expect(testVal, true);
  });

  testWidgets('Check default text is used', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text("Continue with Facebook"), findsOneWidget);
  });

  testWidgets('Check supplied text is used', (WidgetTester tester) async {
    const suppliedText = "Hello, World!";

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            onPressed: () {},
            text: suppliedText,
          ),
        ),
      ),
    );

    expect(find.text(suppliedText), findsOneWidget);
  });

  testWidgets('Check default text style is used', (WidgetTester tester) async {
    const defaultTextStyle = TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            onPressed: () {},
          ),
        ),
      ),
    );

    var text = find.byType(Text).evaluate().toList()[0].widget as Text;
    expect(text.style!.fontSize, defaultTextStyle.fontSize);
    expect(text.style!.fontWeight, defaultTextStyle.fontWeight);
    expect(text.style!.color, defaultTextStyle.color);
  });

  testWidgets('Check supplied text style is used', (WidgetTester tester) async {
    const suppliedTextStyle = TextStyle(
        color: Color(0xff000000),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: "Roboto");
    var buttonKey = UniqueKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            key: buttonKey,
            onPressed: () {},
            textStyle: suppliedTextStyle,
          ),
        ),
      ),
    );

    final FacebookSignInButton button =
        tester.firstWidget(find.byType(FacebookSignInButton));
    expect(button.textStyle, suppliedTextStyle);
  });

  testWidgets('Check supplied splash color is used',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FacebookSignInButton(
            onPressed: () {},
            splashColor: Colors.white,
          ),
        ),
      ),
    );

    var button = find.byType(StretchableButton).evaluate().toList()[0].widget
        as StretchableButton;
    expect(button.splashColor, Colors.white);
  });

  testWidgets('Check default splash color is used',
      (WidgetTester tester) async {
    late ButtonThemeData buttonTheme;

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          buttonTheme = ButtonTheme.of(context);
          return FacebookSignInButton(
            onPressed: () {},
          );
        },
      ),
    ));

    var button = find.byType(ElevatedButton).evaluate().toList()[0].widget
        as ElevatedButton;
    expect(buttonTheme.getSplashColor(button),
        buttonTheme.getTextColor(button).withOpacity(0.12));
  });
}
