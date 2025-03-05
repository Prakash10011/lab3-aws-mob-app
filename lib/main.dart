import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DigitalPictureFrame(),
    );
  }
}

class DigitalPictureFrame extends StatefulWidget {
  @override
  _DigitalPictureFrameState createState() => _DigitalPictureFrameState();
}

class _DigitalPictureFrameState extends State<DigitalPictureFrame> {
  // Replace these URLs with your actual AWS S3 image URLs stored in the 'aws' folder
  final List<String> imageUrls = [
    'https://www.betterfelt.ca/cdn/shop/articles/Nepal_Blog_Post.jpg?v=1650641814',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhaPr4HKsSr27J78iITRAjI-sH6bB6zfzm1w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJWW1fBQUcy_05S57AQjf7f1B-TVrFVmV3qg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTKO26v0FEYwcnu_ak4RZSpeZrx9vapXiASg&s',
  ];

  int _currentImageIndex = 0;
  late Timer _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    // Start the timer to change images every 10 seconds
    _startImageRotation();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  // Function to change the current image index
  void _changeImage(Timer timer) {
    if (!_isPaused) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % imageUrls.length;
      });
    }
  }

  // Start the image rotation
  void _startImageRotation() {
    _timer = Timer.periodic(Duration(seconds: 10), _changeImage);
  }

  // Pause or resume the image rotation
  void _togglePauseResume() {
    setState(() {
      _isPaused = !_isPaused;
    });
    if (!_isPaused) {
      _startImageRotation();  // Restart the rotation if resumed
    } else {
      _timer.cancel();  // Stop the rotation if paused
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the frame
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the frame
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // Responsive width
                height: MediaQuery.of(context).size.height * 0.5, // Responsive height
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 8), // Custom border
                  borderRadius: BorderRadius.circular(20), // Rounded corners for the frame
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[_currentImageIndex],
                    fit: BoxFit.cover, // Ensures the image fills the frame area
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(), // Loading indicator
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error, color: Colors.red), // Error widget
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _togglePauseResume,
                child: Text(_isPaused ? 'Resume' : 'Pause'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
