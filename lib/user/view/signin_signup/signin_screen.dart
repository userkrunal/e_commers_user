import 'package:e_commers_user/user/firebase_helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController txtEmail=TextEditingController();
  TextEditingController txtPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(height: 30.h,width: 40.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img1.png"),fit: BoxFit.fill))),
              ),
              SizedBox(height: 40),
              TextField(
                controller: txtEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.indigoAccent,),
                  focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.indigoAccent.shade100,width: 2)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent.shade100),borderRadius: BorderRadius.circular(20)),
                  label: Text("Name",style: TextStyle(color: Colors.indigoAccent.shade200),)
                )
              ),
              SizedBox(height: 20),
              TextField(
                controller: txtPassword,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password,color: Colors.indigoAccent,),
                  focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.indigoAccent.shade100,width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigoAccent.shade100),borderRadius: BorderRadius.circular(20)
                 ),

                  label: Text("Password",style: TextStyle(color: Colors.indigoAccent.shade200),)
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      String msg=await FirebaseHelper.helper.createUser(txtEmail.text, txtPassword.text);
                      Get.snackbar('success', '',backgroundColor: msg=='faild'?Colors.red.shade100:Colors.green.shade100);
                      if(msg=='success')
                        {
                          Get.toNamed('/home');
                        }
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.indigoAccent.shade100
                      ),
                      child: Center(child: Text("SignIn",style: TextStyle(fontSize: 20,color: Colors.white),)),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.indigoAccent.shade100
                    ),
                    child: Center(child: Text("SignUp",style: TextStyle(fontSize: 20,color: Colors.white),)),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {

                      String msg=await FirebaseHelper.helper.load();
                      Get.snackbar('success', '',backgroundColor: msg=='faild'?Colors.red.shade100:Colors.green.shade100);
                      if(msg=='success')
                      {
                        Get.toNamed('/home');
                      }
                      FirebaseHelper.helper.userditailes();
                    },
                      child: Container(height: 40,width: 40,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img_1.png"),fit: BoxFit.fill)))),
                  InkWell(
                    onTap: () async {
                      String msg=await FirebaseHelper.helper.googleSignIn();
                      Get.snackbar('$msg','',backgroundColor: msg=="success"?Colors.green:Colors.red );
                      if(msg=="success")
                      {
                        Get.toNamed('/signin');
                      }
                    },
                      child: Container(height: 40,width: 40,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img_2.png"),fit: BoxFit.fill)))),
                  Container(height: 40,width: 40,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img_3.png"),fit: BoxFit.fill))),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
