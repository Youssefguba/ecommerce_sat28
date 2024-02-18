import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<Response> login(String email, String password) async {
    final response = await _dio.post(
      'https://student.valuxapps.com/api/login',
      data: {
        "email": email,
        "password": password,
      },
    );
    return response;
  }
}
