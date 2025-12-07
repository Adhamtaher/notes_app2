import 'package:cloud_firestore/cloud_firestore.dart';

class Note{
  final String? id;
  final String headline;
  final String description;
  final Timestamp createdAt;

  Note({
    this.id,
    required this.headline,
    required this.description,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json, String id) =>
      Note(
        id: id,
        headline: json['headline'],
        description: json['description'],
        createdAt: json['createdAt'] ?? Timestamp.now(),
      );

  Map<String, dynamic> toJson() =>
      {
        'headline': headline,
        'description': description,
        'timeCreated': createdAt,
      };
}
