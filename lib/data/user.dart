import 'dart:convert';

class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  //tojson string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  //from json string
  factory User.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User.fromJson(json);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }

  @override
  String toString() {
    return 'User{username: $username, password: $password}';  
  }
}

// list active users
List<User> activeUsers = [
  User(username: 'admin', password: 'admin'),
  User(username: 'user', password: 'user'),
];
