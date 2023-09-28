import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String slug;
  final bool isParent;
  final String description;
  final String date;

  const CustomCard(
      {super.key,
      required this.slug,
      required this.isParent,
      required this.description,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: isParent == true ? Colors.grey[400] : Colors.grey[200],
      child: SizedBox(
        height: null,
        width: double.infinity,
        child: Padding(padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(slug, style: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),),
            Text(description, style: const TextStyle(fontSize: 12.0, color: Colors.black38),),
            Text(date, style: const TextStyle(fontSize: 10.0, color: Colors.black54),)
          ],
        ),),
      ),
      // child: Text(slug),
    );
  }
}
