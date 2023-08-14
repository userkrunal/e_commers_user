import 'package:e_commers_user/user/controller/product_controller.dart';
import 'package:e_commers_user/user/firebase_helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../payment/razerpay.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  ProductController controller=Get.put(ProductController());
  int index=0;
  @override
  void initState() {
    super.initState();
    index=Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Brand: PARTH DESIGNS ",style: TextStyle(fontSize: 20,color: Colors.blue),),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  FirebaseHelper.helper.addcart(controller.productList[index]);
                }, icon: Icon(Icons.add_shopping_cart_rounded))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("AMATA Eagle Sofa Cum Bed with Two Cushions Perfect for Home Living Room and Guests (Camel)"),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  //SizedBox(width: 10),
                  Container(
                    height: 5.h,
                    width: 10.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red.shade500,image: DecorationImage(image: AssetImage("assets/images/img_5.png"),fit: BoxFit.cover)),
                    // child: Center(child: Text("35% ",style: TextStyle(color: Colors.white),)),

                  ),
                  Spacer(),
                  Container(
                      height: 5.h,
                      width: 10.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white70),
                      child: Icon(Icons.share_outlined,size: 30,color: Colors.black,))
                ],
              ),
            ),

            Container(
              height: 40.h,width: 100.w,
              decoration: BoxDecoration( color: Colors.grey.shade300),
              child: Column(
                children: [
                  Container(height: 40.h,width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(controller.productList[
                            index]
                                .image !=
                                null
                                ? "${controller.productList[index].image}"
                                : "https://m.media-amazon.com/images/I/71lG7br7k1L._SX679_.jpg"),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${controller.productList[index].name}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300),),
                  Spacer(),
                  Text("⭐⭐⭐⭐⭐"),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 15),
                Text("-48%",style: TextStyle(fontSize: 35,color: Colors.red,fontWeight: FontWeight.w300)),
                SizedBox(width: 9),
                Text("\$${controller.productList[index].price}",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.w300)),
              ],
            ),
           SizedBox(height: 20),
           Row(
             children: [
               SizedBox(width: 20),
               Text("EMI",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18)),
               SizedBox(width: 5),
               Text("form 480.No Cost EMI available.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18)),

             ],
           ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                FirebaseHelper.helper.addcart(controller.productList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 50,
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber),
                  child: Text("Add to Cart"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                PaymentHelper.payment.setPayment(1000);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 50,
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber.shade700),
                  child: Text("Buy Now"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Icon(Icons.lock,color: Colors.black54),
                  SizedBox(width: 10),
                  Text("Secure transaction",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.blue.shade200,fontSize: 18),),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300,thickness: 3),
            Row(
              children: [
                SizedBox(width: 20),
                Column(
                  children: [
                    Container(height: 50,width: 50,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("assets/images/img_6.png"),fit: BoxFit.fill))),
                    Text("Free Delivery",style: TextStyle(color: Colors.blue.shade400,fontWeight: FontWeight.w300))
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Container(height: 50,width: 50,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("assets/images/img_7.png"),fit: BoxFit.fill))),
                    Text("10 Day Replasment",style: TextStyle(color: Colors.blue.shade400,fontWeight: FontWeight.w300))
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300,thickness: 3),
          ],
        ),
      ),
    ));
  }
}
