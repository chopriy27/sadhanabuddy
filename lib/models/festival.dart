import 'package:cloud_firestore/cloud_firestore.dart';

class Festival {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String type; // Appearance Day, Disappearance Day, Ekadashi, Festival
  final String imageUrl;
  final bool isEkadashi;
  final String? relatedAcharyaId;
  
  Festival({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.type,
    this.imageUrl = '',
    this.isEkadashi = false,
    this.relatedAcharyaId,
  });
  
  factory Festival.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Festival(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      isEkadashi: data['isEkadashi'] ?? false,
      relatedAcharyaId: data['relatedAcharyaId'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'date': Timestamp.fromDate(date),
      'type': type,
      'imageUrl': imageUrl,
      'isEkadashi': isEkadashi,
      'relatedAcharyaId': relatedAcharyaId,
    };
  }
}