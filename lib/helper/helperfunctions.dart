import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String USER_LOGGED_IN = "ISLOGGEDIN";
  static String USER_NAME = "USERNAME";
  static String USER_EMAIL = "USEREMAIL";

  // saving data to sharedpreference
  // saving user log in data

  static Future<bool> saveUserLoggedState(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(USER_LOGGED_IN, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(USER_NAME, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(USER_EMAIL, userEmail);
  }

  // fetching data from sharedPreferences

  static Future<bool> getUserLoggedState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(USER_LOGGED_IN);
  }

  static Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(USER_NAME);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(USER_EMAIL);
  }
}
