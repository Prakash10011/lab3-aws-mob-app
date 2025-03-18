Digital Picture Frame App :
Overview:
This is a Digital Picture Frame app built using Flutter. It loads and displays images from a list of URLs and automatically rotates through them every 10 seconds. The app also includes a pause and resume button to control the image rotation.

Features:
Displays images from network URLs using CachedNetworkImage
Automatically rotates images every 10 seconds
Allows users to pause and resume the rotation
Handles loading and error states with appropriate UI feedback
Clean and responsive user interface with rounded corners and shadow effects

How It Works:
Image Loading:

The app loads a list of image URLs.
CachedNetworkImage handles loading and caching the images.

Automatic Rotation:

A timer changes the image every 10 seconds.
_currentImageIndex determines which image is displayed next.
Pause/Resume:

User can pause or resume the rotation using a button.
Timer is canceled when paused and restarted when resumed.
UI Handling:

Displays a loading indicator while fetching images.
Displays an error icon if the image fails to load.

Project Structure:
Key Files:

main.dart – Contains the full app logic and UI.
pubspec.yaml – Manages dependencies like CachedNetworkImage.
State Management
setState() updates the current image and UI state.
Timer is managed using Timer.periodic() to handle automatic rotation.

Changes Made:
Implemented automatic image rotation with a timer.
Added pause and resume functionality.
Improved UI with rounded corners and shadow effects.
Added loading and error handling using CachedNetworkImage.

Why These Changes:
To provide a smooth user experience with seamless image transitions.
To give users control over the rotation using a pause/resume button.
To handle network issues gracefully with loading and error indicators.
