import 'package:flutter/material.dart';
import '/utils/routes/routes_name.dart';
import '/view/signup_view.dart';
import '/view/splash_view.dart';
import '../../view/home_screen.dart';

import '../../view/login_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashView(),);
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginView(),);
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpView(),);
        default:
          return MaterialPageRoute(builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
          );
    }
  }
}