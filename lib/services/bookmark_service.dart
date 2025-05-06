import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String _key = 'Bookmarked Titles';

  Future<void> SwitchingBookmark(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(_key) ?? [];

    if (currentList.contains(title)) {
      currentList.remove(title);
    } else {
      currentList.add(title);
    }
    await prefs.setStringList(_key, currentList);
  }

  static Future<bool> isBookmarked(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_key) ?? [];
    return bookmarks.contains(title);
  }

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
