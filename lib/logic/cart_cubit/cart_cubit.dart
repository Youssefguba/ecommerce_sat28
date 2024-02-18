import 'package:bloc/bloc.dart';
import 'package:ecommerce_trining/repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());


  void addToCart(int productId) async {
    try {
      emit(ItemAddedLoading());
      final res = await CartRepository().addItemToCart(productId);

      final status = res.data['status'] as bool;
      final message = res.data['message'] as String;

      if (status) {
        emit(ItemAddSuccessfully());
      } else if (message == 'غير مصرح لك') {
        emit(NotAuthorizedInCart());
      }
    } on Exception catch (e) {
      emit(GeneralErrorInCart());
    }

    // Success

    // Not Found

    // [x] Not Authorized

    // [x] General Error
  }
}
