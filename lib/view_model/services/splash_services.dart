import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '/utils/routes/routes_name.dart';

import '/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices {
  void checkAuthentication(BuildContext context){
    getUserData().then((value) async{
      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
  Future<UserModel> getUserData() => UserViewModel().getUser();
}