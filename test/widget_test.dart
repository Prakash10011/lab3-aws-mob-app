import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aws/main.dart'; // Import your main.dart file

void main() {
  testWidgets('Image rotation and pause/resume functionality', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the digital picture frame is displaying an image.
    expect(find.byType(CachedNetworkImage), findsOneWidget);

    // Verify that the pause button is present.
    expect(find.text('Pause'), findsOneWidget);

    // Tap the pause button to pause the image rotation.
    await tester.tap(find.text('Pause'));
    await tester.pump();

    // Verify that the button text changed to "Resume" after tapping.
    expect(find.text('Resume'), findsOneWidget);

    // After pausing, the image should not change automatically.
    // So, we simulate waiting 10 seconds and check if the image is still the same.
    final firstImage = find.byType(CachedNetworkImage);
    await tester.pump(Duration(seconds: 10));

    // Ensure the image hasn't changed because the rotation is paused.
    expect(find.byType(CachedNetworkImage), firstImage);

    // Now resume the image rotation by tapping the "Resume" button.
    await tester.tap(find.text('Resume'));
    await tester.pump();

    // Verify that the button text changed to "Pause" after resuming.
    expect(find.text('Pause'), findsOneWidget);

    // Verify that the image changes after resuming (simulate another 10-second delay).
    await tester.pump(Duration(seconds: 10));

    // Verify that the image has changed (index should change).
    expect(find.byType(CachedNetworkImage), isNot(firstImage));
  });
}
