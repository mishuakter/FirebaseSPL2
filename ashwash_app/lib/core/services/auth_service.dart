import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../../data/models/user_model.dart';

class AuthService {
  String? _token;
  UserModel? _currentUser;

  String? get token => _token;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String email, String password) async {
    try {
      // Mock / Real API attempt
      _token = 'mock_jwt_access_token_ashwash_2026';
      _currentUser = UserModel(
        id: 1,
        username: email.split('@')[0],
        email: email,
        firstName: 'User',
        lastName: '',
        totalPoints: 450,
        sessionsAttended: 5,
        tasksCompleted: 1,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    _token = 'mock_jwt_access_token_ashwash_2026';
    _currentUser = UserModel(
      id: 2,
      username: username,
      email: email,
      firstName: username,
      lastName: '',
      totalPoints: 0,
      sessionsAttended: 0,
      tasksCompleted: 0,
    );
    return true;
  }

  void logout() {
    _token = null;
    _currentUser = null;
  }
}
