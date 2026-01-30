import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; 
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        throw AuthException(
          message: 'Este e-mail já está em uso. Tente fazer login ou use outro método (Google/Senha).',
        );
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
  }
    }
  }
}
