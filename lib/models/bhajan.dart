import 'package:cloud_firestore/cloud_firestore.dart';

class Bhajan {
  final String id;
  final String title;
  final String acharyaId;
  final String acharyaName;
  final String category; // Morning, Evening, Meditation, Festival
  final String lyrics;
  final String? youtubeUrl;
  final String? audioUrl;
  final String? translation;
  final List<String> tags;
  
  Bhajan({
    required this.id,
    required this.title,
    required this.acharyaId,
    required this.acharyaName,
    required this.category,
    required this.lyrics,
    this.youtubeUrl,
    this.audioUrl,
    this.translation,
    this.tags = const [],
  });
  
  factory Bhajan.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Bhajan(
      id: doc.id,
      title: data['title'] ?? '',
      acharyaId: data['acharyaId'] ?? '',
      acharyaName: data['acharyaName'] ?? '',
      category: data['category'] ?? '',
      lyrics: data['lyrics'] ?? '',
      youtubeUrl: data['youtubeUrl'],
      audioUrl: data['audioUrl'],
      translation: data['translation'],
      tags: List<String>.from(data['tags'] ?? []),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'acharyaId': acharyaId,
      'acharyaName': acharyaName,
      'category': category,
      'lyrics': lyrics,
      'youtubeUrl': youtubeUrl,
      'audioUrl': audioUrl,
      'translation': translation,
      'tags': tags,
    };
  }
}