class ApiEndpoints {
  // Base API URL (Configurable for Local Host, Android Emulator 10.0.2.2, or Production Server)
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1'; // Default for Android Emulator

  // Authentication Endpoints
  static const String register = '$baseUrl/auth/register/';
  static const String login = '$baseUrl/auth/login/';
  static const String tokenRefresh = '$baseUrl/auth/token/refresh/';
  static const String profile = '$baseUrl/auth/profile/';
  static const String categoryPreference = '$baseUrl/auth/category-preference/';

  // Dashboard Endpoints
  static const String dashboardOverview = '$baseUrl/dashboard/overview/';

  // Mood & Progress Endpoints
  static const String moodLogs = '$baseUrl/mood/logs/';
  static const String mentalHealthReport = '$baseUrl/mood/report/';

  // Knowledge Hub & Mind Games Endpoints
  static const String hubResources = '$baseUrl/hub/resources/';
  static const String mindGames = '$baseUrl/hub/mind-games/';
  static const String gameScore = '$baseUrl/hub/mind-games/score/';

  // Courses & Assignments Endpoints
  static const String courses = '$baseUrl/courses/';
}
