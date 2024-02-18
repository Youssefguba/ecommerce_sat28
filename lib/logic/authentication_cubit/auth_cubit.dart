import 'package:bloc/bloc.dart';
import 'package:ecommerce_trining/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginByEmail(String email, String password) async {
    emit(LoginLoading());

    try {
      final res = await AuthRepository().login(email, password);
      final status = res.data['status'] as bool;
      if (status) {
        final userToken = res.data['data']['token'] as String;
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', userToken);
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    } catch (e) {
      emit(LoginFailed());
    }
  }
}
