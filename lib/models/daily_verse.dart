import 'package:cloud_firestore/cloud_firestore.dart';

class DailyVerse {
  final String id;
  final String verse;
  final String translation;
  final String purport;
  final String reference; // e.g., "Bhagavad Gita 2.47"
  final DateTime date;
  
  DailyVerse({
    required this.id,
    required this.verse,
    required this.translation,
    required this.purport,
    required this.reference,
    required this.date,
  });
  
  factory DailyVerse.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DailyVerse(
      id: doc.id,
      verse: data['verse'] ?? '',
      translation: data['translation'] ?? '',
      purport: data['purport'] ?? '',
      reference: data['reference'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'verse': verse,
      'translation': translation,
      'purport': purport,
      'reference': reference,
      'date': Timestamp.fromDate(date),
    };
  }
}