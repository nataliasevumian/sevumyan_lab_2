import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifCard extends StatelessWidget {
  final String name;
  final String? image;

  GifCard({
    this.name = '',
    this.image
  });

  factory GifCard.fromJson(dynamic json) => GifCard(
      name: json['title'],
      image: json['images']['original']['url']
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Image(image: NetworkImage(image!)),
            const SizedBox(height: 20)
          ],
        )
      ),
    );
  }
}