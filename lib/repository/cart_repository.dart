import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final Dio _dio = Dio();

  // addToCart
  Future<Response> addItemToCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.post(
      'https://student.valuxapps.com/api/carts',
      data: {
        "product_id": productId,
      },
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
    );

    return response;
  }

  // getAllCart

  // updateCart

  // removeCart
}

void main() {
  CartRepository().addItemToCart(1);
}
