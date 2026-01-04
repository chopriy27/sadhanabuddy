import 'package:cloud_firestore/cloud_firestore.dart';

class SadhanaEntry {
  final String id;
  final String userId;
  final DateTime date;
  final int japaRounds;
  final int readingMinutes;
  final bool attendedMangalaArati;
  final bool attendedDarsana;
  final int serviceHours;
  final String journalEntry;
  final DateTime? createdAt;
  
  SadhanaEntry({
    this.id = '',
    required this.userId,
    required this.date,
    this.japaRounds = 0,
    this.readingMinutes = 0,
    this.attendedMangalaArati = false,
    this.attendedDarsana = false,
    this.serviceHours = 0,
    this.journalEntry = '',
    this.createdAt,
  });
  
  factory SadhanaEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SadhanaEntry(
      id: doc.id,
      userId: data['userId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      japaRounds: data['japaRounds'] ?? 0,
      readingMinutes: data['readingMinutes'] ?? 0,
      attendedMangalaArati: data['attendedMangalaArati'] ?? false,
      attendedDarsana: data['attendedDarsana'] ?? false,
      serviceHours: data['serviceHours'] ?? 0,
      journalEntry: data['journalEntry'] ?? '',
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : null,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'japaRounds': japaRounds,
      'readingMinutes': readingMinutes,
      'attendedMangalaArati': attendedMangalaArati,
      'attendedDarsana': attendedDarsana,
      'serviceHours': serviceHours,
      'journalEntry': journalEntry,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }
  
  SadhanaEntry copyWith({
    String? id,
    String? userId,
    DateTime? date,
    int? japaRounds,
    int? readingMinutes,
    bool? attendedMangalaArati,
    bool? attendedDarsana,
    int? serviceHours,
    String? journalEntry,
    DateTime? createdAt,
  }) {
    return SadhanaEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      japaRounds: japaRounds ?? this.japaRounds,
      readingMinutes: readingMinutes ?? this.readingMinutes,
      attendedMangalaArati: attendedMangalaArati ?? this.attendedMangalaArati,
      attendedDarsana: attendedDarsana ?? this.attendedDarsana,
      serviceHours: serviceHours ?? this.serviceHours,
      journalEntry: journalEntry ?? this.journalEntry,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}