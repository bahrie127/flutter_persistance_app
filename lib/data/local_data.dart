import 'package:flutter_shared_preferences_app/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  void saveData(int value) async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    // Save the counter value to persistent storage under the 'counter' key.
    await prefs.setInt('counter', value);
  }

  Future<int> loadData() async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the 'counter' key. If it doesn't exist, return 0.
    return prefs.getInt('counter') ?? 0;
  }

  //save login flag
  void saveLoginFlag(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  //load login flag
  Future<bool> loadLoginFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toJsonString());
  }

  //load user data
  Future<User?> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString != null) {
      return User.fromJsonString(jsonString);
    }
    return null;
  }

  //delete data
  void deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('counter');
  }
}
