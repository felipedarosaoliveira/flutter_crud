class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String imageUrl;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.imageUrl = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
    };
    if (id != null) {
      data["id"] = id;
    }
    return data;
  }
}
