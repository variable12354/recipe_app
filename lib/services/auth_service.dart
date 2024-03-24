
import '../models/user.dart';
import 'http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  User? user;

  final _httpService = HttpService();
  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async{
    print("username $username password $password");
    try{
      var response  = await _httpService.post("auth/login", {
        "username": username,
        "password": password
      });
      if(response?.statusCode == 200 && response?.data != null){
        print(response!.data);
        user = User.fromJson(response.data);
        HttpService().setup(bearerToken: user!.token);
        return true;
      }
    }catch(e){
      print(e);
    }
    return false;
  }
}
