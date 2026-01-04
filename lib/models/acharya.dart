import 'package:cloud_firestore/cloud_firestore.dart';

class Acharya {
  final String id;
  final String name;
  final String title; // e.g., "His Divine Grace", "Srila"
  final String biography;
  final String imageUrl;
  final DateTime? birthDate;
  final DateTime? disappearanceDate;
  final List<String> contributions;
  final List<String> bhajanIds;
  
  Acharya({
    required this.id,
    required this.name,
    this.title = '',
    required this.biography,
    required this.imageUrl,
    this.birthDate,
    this.disappearanceDate,
    this.contributions = const [],
    this.bhajanIds = const [],
  });
  
  factory Acharya.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Acharya(
      id: doc.id,
      name: data['name'] ?? '',
      title: data['title'] ?? '',
      biography: data['biography'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      birthDate: data['birthDate'] != null 
          ? (data['birthDate'] as Timestamp).toDate() 
          : null,
      disappearanceDate: data['disappearanceDate'] != null 
          ? (data['disappearanceDate'] as Timestamp).toDate() 
          : null,
      contributions: List<String>.from(data['contributions'] ?? []),
      bhajanIds: List<String>.from(data['bhajanIds'] ?? []),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'biography': biography,
      'imageUrl': imageUrl,
      'birthDate': birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      'disappearanceDate': disappearanceDate != null ? Timestamp.fromDate(disappearanceDate!) : null,
      'contributions': contributions,
      'bhajanIds': bhajanIds,
    };
  }
}