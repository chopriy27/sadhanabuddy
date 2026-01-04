import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String location;
  final List<String> booksRead;
  final List<String> classesListened;
  final List<String> following;
  final List<String> followers;
  final int totalJapaRounds;
  final int totalReadingMinutes;
  final DateTime? createdAt;
  
  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl = '',
    this.location = '',
    this.booksRead = const [],
    this.classesListened = const [],
    this.following = const [],
    this.followers = const [],
    this.totalJapaRounds = 0,
    this.totalReadingMinutes = 0,
    this.createdAt,
  });
  
  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      location: data['location'] ?? '',
      booksRead: List<String>.from(data['booksRead'] ?? []),
      classesListened: List<String>.from(data['classesListened'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      followers: List<String>.from(data['followers'] ?? []),
      totalJapaRounds: data['totalJapaRounds'] ?? 0,
      totalReadingMinutes: data['totalReadingMinutes'] ?? 0,
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : null,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'location': location,
      'booksRead': booksRead,
      'classesListened': classesListened,
      'following': following,
      'followers': followers,
      'totalJapaRounds': totalJapaRounds,
      'totalReadingMinutes': totalReadingMinutes,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }
}