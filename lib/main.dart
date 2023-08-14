import 'package:e_commers_user/user/view/add_cart_screen.dart';
import 'package:e_commers_user/user/view/data_screen.dart';
import 'package:e_commers_user/user/view/home_screen.dart';
import 'package:e_commers_user/user/view/signin_signup/signin_screen.dart';
import 'package:e_commers_user/user/view/signin_signup/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

Future<void> main()
async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(p0) =>SplashScreen(),
          '/signin':(p0) =>SignInScreen(),
          '/home':(p0) =>HomeScreen(),
          '/data':(p0) =>DataScreen(),
          '/addtocart':(p0) =>AddToCart(),
        },
      );
    },)
  );
}