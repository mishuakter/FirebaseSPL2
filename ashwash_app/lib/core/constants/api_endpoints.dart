class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Android Emulator default

  static const String login = '$baseUrl/auth/login/';
  static const String register = '$baseUrl/auth/register/';
  static const String profile = '$baseUrl/auth/profile/';
  static const String categories = '$baseUrl/auth/categories/';
  static const String selectCategory = '$baseUrl/auth/select-category/';

  static const String moodLogs = '$baseUrl/mood/logs/';
  static const String moodAnalytics = '$baseUrl/mood/analytics/';

  static const String questionnaires = '$baseUrl/assessment/questionnaires/';
  static const String submitAssessment = '$baseUrl/assessment/submit/';

  static const String resources = '$baseUrl/knowledge/resources/';

  static const String courses = '$baseUrl/courses/';
  static const String enrolledCourses = '$baseUrl/courses/enrolled/';

  static const String specialists = '$baseUrl/appointments/specialists/';
  static const String bookings = '$baseUrl/appointments/bookings/';

  static const String posts = '$baseUrl/community/posts/';
  static const String payments = '$baseUrl/payments/initiate/';

  static const String dashboardSummary = '$baseUrl/dashboard/summary/';
}
