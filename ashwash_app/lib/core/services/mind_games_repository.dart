import 'package:shared_preferences/shared_preferences.dart';

class MindGamesRepository {
  static const String _keyBestScore = 'mind_games_best_score_';
  static const String _keyLastScore = 'mind_games_last_score_';
  static const String _keyPlayCount = 'mind_games_play_count_';
  static const String _keyTotalTime = 'mind_games_total_time_';
  static const String _keyLastPlayed = 'mind_games_last_played_';

  // Save Game Score locally
  Future<void> saveGameScore({
    required String gameId,
    required int score,
    required int durationSeconds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Update Best Score
    int currentBest = prefs.getInt('$_keyBestScore$gameId') ?? 0;
    if (score > currentBest) {
      await prefs.setInt('$_keyBestScore$gameId', score);
    }

    // Save Last Score
    await prefs.setInt('$_keyLastScore$gameId', score);

    // Update Play Count
    int currentPlayCount = prefs.getInt('$_keyPlayCount$gameId') ?? 0;
    await prefs.setInt('$_keyPlayCount$gameId', currentPlayCount + 1);

    // Update Total Time Played
    int currentTotalTime = prefs.getInt('$_keyTotalTime$gameId') ?? 0;
    await prefs.setInt('$_keyTotalTime$gameId', currentTotalTime + durationSeconds);

    // Save Last Played Date
    await prefs.setString('$_keyLastPlayed$gameId', DateTime.now().toIso8601String());

    // Future Django REST API Sync Stub
    await _syncScoreToBackend(gameId: gameId, score: score, durationSeconds: durationSeconds);
  }

  // Get Best Score
  Future<int> getBestScore(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_keyBestScore$gameId') ?? 0;
  }

  // Get Game Stats
  Future<Map<String, dynamic>> getGameStats(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'bestScore': prefs.getInt('$_keyBestScore$gameId') ?? 0,
      'lastScore': prefs.getInt('$_keyLastScore$gameId') ?? 0,
      'playCount': prefs.getInt('$_keyPlayCount$gameId') ?? 0,
      'totalTimePlayed': prefs.getInt('$_keyTotalTime$gameId') ?? 0,
      'lastPlayedDate': prefs.getString('$_keyLastPlayed$gameId') ?? '',
    };
  }

  // Future Django Backend Sync Method (Service Layer Ready)
  Future<bool> _syncScoreToBackend({
    required String gameId,
    required int score,
    required int durationSeconds,
  }) async {
    // API endpoint call logic will seamlessly execute here once server endpoint is live
    return true;
  }
}
