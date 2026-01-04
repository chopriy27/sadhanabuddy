import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bhajan.dart';
import '../models/acharya.dart';
import '../models/daily_verse.dart';

class ContentProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<Bhajan> _bhajans = [];
  List<Acharya> _acharyas = [];
  DailyVerse? _dailyVerse;
  bool _isLoading = false;
  
  List<Bhajan> get bhajans => _bhajans;
  List<Acharya> get acharyas => _acharyas;
  DailyVerse? get dailyVerse => _dailyVerse;
  bool get isLoading => _isLoading;
  
  Future<void> loadBhajans() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final snapshot = await _firestore.collection('bhajans').get();
      _bhajans = snapshot.docs.map((doc) => Bhajan.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error loading bhajans: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> loadAcharyas() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final snapshot = await _firestore.collection('acharyas').get();
      _acharyas = snapshot.docs.map((doc) => Acharya.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error loading acharyas: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> loadDailyVerse() async {
    try {
      final today = DateTime.now();
      final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      
      final doc = await _firestore.collection('daily_verses').doc(todayStr).get();
      
      if (doc.exists) {
        _dailyVerse = DailyVerse.fromFirestore(doc);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading daily verse: $e');
    }
  }
  
  List<Bhajan> getBhajansByCategory(String category) {
    return _bhajans.where((b) => b.category == category).toList();
  }
  
  List<Bhajan> getBhajansByAcharya(String acharyaId) {
    return _bhajans.where((b) => b.acharyaId == acharyaId).toList();
  }
}