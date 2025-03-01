import 'package:adwa/models/character.dart';
import 'package:adwa/screens/character_detail_screen.dart';
import 'package:adwa/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatefulWidget {
  const CharacterWidget({super.key});

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextCharacter() {
    if (_currentIndex < characters.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCharacter() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: characters.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final character = characters[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 350),
                    pageBuilder: (context, _, __) => CharacterDetailScreen(character: character),
                  ),
                );
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: CharacterCardBackgroundClipper(),
                      child: Hero(
                        tag: "background-${character.name}",
                        child: Container(
                          height: 0.6 * screenHeight,
                          width: 0.9 * screenWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green.shade400, Colors.yellow.shade400,Colors.red.shade400],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.5),
                    child: Hero(
                      tag: "image-${character.name}",
                      child: Image.asset(
                        character.imagePath,
                        height: screenHeight * 0.55,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Hero(
                          tag: "name-${character.name}",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              character.name,
                              style: AppTheme.heading,
                            ),
                          ),
                        ),
                        Text(
                          "Tap to Read more",
                          style: AppTheme.subHeading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          left: 5,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: _currentIndex > 0 ? Colors.black : Colors.grey),
            onPressed: _currentIndex > 0 ? _previousCharacter : null,
          ),
        ),
        Positioned(
          right: 16,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios,
                color: _currentIndex < characters.length - 1 ? Colors.black : Colors.grey),
            onPressed: _currentIndex < characters.length - 1 ? _nextCharacter : null,
          ),
        ),
      ],
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width, size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0, size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.25);
    clippedPath.quadraticBezierTo(1, (size.height * 0.25) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
