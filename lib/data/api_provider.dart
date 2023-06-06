import 'dart:convert';
import 'package:crud_gpt/models/user.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class APIProvider {
  static const String baseUrl = 'http://example.com/api';

  static Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Autenticação do usuário
  static Future<bool> authenticateUser(String email, String password) async {
    try {
      final response = await _dio
          .post('/user/login', data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  // Registro do usuário
  static Future<User?> registerUser(
      String name, String email, String password, XFile image) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'image': await MultipartFile.fromFile(image.path,
            filename: 'user_image', contentType: MediaType('image', 'jpeg')),
      });

      final response = await _dio.post('/user/register', data: formData);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.data);
        User user = User.fromJson(responseData);
        return user;
      } else {
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Recuperação de senha
  static Future<bool> forgotPassword(String email) async {
    try {
      final response =
          await _dio.post('/user/forgot_password', data: {'email': email});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
