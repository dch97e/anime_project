import 'dart:async';

import 'package:anime_database/domain/auth_repository.dart';
import 'package:anime_database/presentation/common/base/base_view_model.dart';
import 'package:anime_database/presentation/common/base/resource_state.dart';
import 'package:anime_database/presentation/common/errorhandling/app_action.dart';
import 'package:anime_database/presentation/view/auth/viewmodel/auth_error_builder.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  StreamController<ResourceState> loginState =
      StreamController<ResourceState>();

  StreamController<bool> signOutState = StreamController<bool>();

  StreamController<bool> authenticatedState = StreamController<bool>();

  Future<void> login(String user, String password) async {
    loginState.add(ResourceState.loading());

    _authRepository
        .login(user, password)
        .then((value) => loginState.add(ResourceState.completed(null)))
        .catchError((e) {
      loginState.add(ResourceState.error(
          AuthErrorBuilder.create(e, AppAction.SIGN_IN).build()));
    });
  }

  Future<void> isAuthenticated() async {
    _authRepository
        .isAuthenticated()
        .then((value) => authenticatedState.add(value))
        .onError((error, stackTrace) => authenticatedState.add(false));
  }

  Future<void> signOut() async {
    _authRepository
        .signOut()
        .then((value) => signOutState.add(true))
        .onError((error, stackTrace) => signOutState.add(false));
  }

  @override
  void dispose() {
    loginState.close();
    authenticatedState.close();
  }
}
