import 'package:adwa/models/character.dart';
import 'package:adwa/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key,required this.character});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "background-${characters[0].name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade200, Colors.yellow.shade200,Colors.red.shade200],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                        tag: "image-{$characters[0].name}",
                        child: Image.asset(widget.character.imagePath, height: screenHeight * 0.45)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                    child: Hero(
                        tag: "name-${characters[0].name}",
                        child: Material(
                          color: Colors.transparent,
                            child: Text(widget.character.name, style: AppTheme.heading))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                    child: Text(widget.character.description, style: AppTheme.subHeading),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
