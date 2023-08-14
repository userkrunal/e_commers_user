import 'dart:async';

import 'package:e_commers_user/user/firebase_helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool users=false;
  @override
  void initState() {

    users=FirebaseHelper.helper.chakuser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4),() {
       users!=false
           ?Get.toNamed('/home'):Get.toNamed('/signin');

    },);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.fill)
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("We Design ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              Text("Furniture For  ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              Text("Your Comfort  ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    ));
  }
}
