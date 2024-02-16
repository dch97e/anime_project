import 'package:anime_database/data/auth/remote/auth_remote_impl.dart';
import 'package:anime_database/domain/auth_repository.dart';

class AuthDataImpl implements AuthRepository {
  final AuthRemoteImpl _remoteImpl;
  AuthDataImpl(this._remoteImpl);

  @override
  Future<void> login(String user, String password) {
    return _remoteImpl.login(user, password);
  }

  @override
  Future<bool> isAuthenticated() {
    return _remoteImpl.isAuthenticated();
  }

  @override
  Future<void> signOut() {
    return _remoteImpl.signOut();
  }
}
