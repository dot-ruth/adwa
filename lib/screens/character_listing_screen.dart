import 'package:adwa/styleguide.dart';
import 'package:adwa/widgets/character_widget.dart';
import 'package:flutter/material.dart';

class CharacterListingScreen extends StatefulWidget {
  const CharacterListingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "ADWA", style: AppTheme.display1),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CharacterWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
