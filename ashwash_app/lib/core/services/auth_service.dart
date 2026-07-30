import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Returns the current Firebase user object
  User? get currentFirebaseUser => _auth.currentUser;
  
  // Check if a user is currently logged in
  bool get isAuthenticated => _auth.currentUser != null;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Real Login using Firebase Authentication
  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      // Optionally fetch additional user profile data from Firestore
      await _fetchUserData(userCredential.user!.uid);
      return true;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  // Real Registration using Firebase Authentication
  Future<bool> register(String username, String email, String password) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = userCredential.user!.uid;

      // 2. Create the user profile model
      _currentUser = UserModel(
        id: 0, // Or use a string UID if your UserModel 'id' field supports it
        username: username,
        email: email,
        firstName: username,
        lastName: '',
        totalPoints: 0,
        sessionsAttended: 0,
        tasksCompleted: 0,
      );

      // 3. Save extra user details to Cloud Firestore
      await _firestore.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'totalPoints': 0,
        'sessionsAttended': 0,
        'tasksCompleted': 0,
        'createdAt': Timestamp.now(),
      });

      return true;
    } catch (e) {
      print("Registration Error: $e");
      return false;
    }
  }

  // Helper method to pull data from Firestore when logging in
  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _currentUser = UserModel(
          id: 0,
          username: data['username'] ?? '',
          email: data['email'] ?? '',
          firstName: data['username'] ?? '',
          lastName: '',
          totalPoints: data['totalPoints'] ?? 0,
          sessionsAttended: data['sessionsAttended'] ?? 0,
          tasksCompleted: data['tasksCompleted'] ?? 0,
        );
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Logout from Firebase
  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
  }
}