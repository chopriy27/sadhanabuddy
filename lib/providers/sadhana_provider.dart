import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/sadhana_entry.dart';

class SadhanaProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  List<SadhanaEntry> _entries = [];
  SadhanaEntry? _todayEntry;
  bool _isLoading = false;
  
  List<SadhanaEntry> get entries => _entries;
  SadhanaEntry? get todayEntry => _todayEntry;
  bool get isLoading => _isLoading;
  
  Future<void> loadTodayEntry() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final user = _auth.currentUser;
      if (user == null) return;
      
      final today = DateTime.now();
      final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sadhana')
          .doc(todayStr)
          .get();
      
      if (doc.exists) {
        _todayEntry = SadhanaEntry.fromFirestore(doc);
      } else {
        _todayEntry = SadhanaEntry(
          date: today,
          userId: user.uid,
        );
      }
    } catch (e) {
      print('Error loading today entry: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> updateJapaRounds(int rounds) async {
    if (_todayEntry == null) return;
    
    _todayEntry = _todayEntry!.copyWith(japaRounds: rounds);
    await _saveTodayEntry();
    notifyListeners();
  }
  
  Future<void> toggleMangalaArati() async {
    if (_todayEntry == null) return;
    
    _todayEntry = _todayEntry!.copyWith(attendedMangalaArati: !_todayEntry!.attendedMangalaArati);
    await _saveTodayEntry();
    notifyListeners();
  }
  
  Future<void> updateReadingMinutes(int minutes) async {
    if (_todayEntry == null) return;
    
    _todayEntry = _todayEntry!.copyWith(readingMinutes: minutes);
    await _saveTodayEntry();
    notifyListeners();
  }
  
  Future<void> addJournalEntry(String entry) async {
    if (_todayEntry == null) return;
    
    _todayEntry = _todayEntry!.copyWith(journalEntry: entry);
    await _saveTodayEntry();
    notifyListeners();
  }
  
  Future<void> _saveTodayEntry() async {
    try {
      final user = _auth.currentUser;
      if (user == null || _todayEntry == null) return;
      
      final today = _todayEntry!.date;
      final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sadhana')
          .doc(todayStr)
          .set(_todayEntry!.toMap());
    } catch (e) {
      print('Error saving entry: $e');
    }
  }
}