import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers_user/user/controller/product_controller.dart';
import 'package:e_commers_user/user/firebase_helper/helper.dart';
import 'package:e_commers_user/user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  ProductController controller=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xffEDEDED),
    //  appBar: AppBar(backgroundColor: Color(0xffEDEDED),title: Text("AddToCart",style: TextStyle(color: Colors.black),),centerTitle: true,leading: Icon(Icons.add_shopping_cart_rounded)),
       body: StreamBuilder(builder: (context, snapshot) {
         if(snapshot.hasError)
         {
           return Text("${snapshot.error}");
         }
         else if(snapshot.hasData)
         {
           QuerySnapshot querySnapshot=snapshot.data!;
           List<QueryDocumentSnapshot> querysnapList =querySnapshot.docs;
           List<AddTOCartModel> cartList=[];

           for(var x in querysnapList)
           {
             Map m1=x.data() as Map;
             String id=x.id;
             String name=m1['name'];
             String cat=m1['category'];
             String dec = m1['description'];
             String img = m1['image'];
             int price = m1['price'];
             AddTOCartModel model=AddTOCartModel(name: name,category: cat,description: dec,image: img,price: price,id: id,qty: 1);
             cartList.add(model);

           }
           return ListView.builder(itemBuilder: (context, index) {
             // return Padding(
             //   padding: const EdgeInsets.all(8.0),
             //   child: ListTile(
             //     leading: Container(height: 60,width: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: NetworkImage("${cartList[index].image}"),fit: BoxFit.fill)),),
             //     title: Text("${cartList[index].name}"),
             //     trailing: Text("${cartList[index].price}"),
             //
             //   ),
             // );
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child:Container(
                   height: 12.h,
                   width: 100.w,
                   padding: EdgeInsets.symmetric(horizontal: 3.w),
                   decoration: BoxDecoration(color:Color(0xffF1F1F1) ,borderRadius: BorderRadius.circular(30)),
                   child: Row(
                     children: [
                       Container(height: 8.h,width: 17.w,
                       decoration:(BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: NetworkImage("${cartList[index].image}"),fit: BoxFit.fill))),
                       ),
                       SizedBox(width: 10),
                        Column(
                           children: [
                             SizedBox(height: 9),
                             Text("${cartList[index].name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                             // SizedBox(height: 10),
                              Container(
                                 height: 3.h,
                                 width: 25.w,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12),
                                 child:  Center(child: Text("\$ ${cartList[index].price! * cartList[index].qty!}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w200))),
                               ),
                           ],
                         ),
                       // SizedBox(width: 25),
                       Spacer(),
                       GestureDetector(
                               onTap: () {
                                 int tqty=cartList[index].qty!;
                                 tqty++;
                                 ProductModel model=ProductModel(
                                   name: cartList[index].name,
                                   price: cartList[index].price,
                                   category: cartList[index].category,
                                   description: cartList[index].description,
                                   image: cartList[index].image,
                                   id: cartList[index].id,
                                   qty: tqty,
                                 );
                                 FirebaseHelper.helper.updtacart(model);
                                 print('=====================================================on tap============');
                               },
                               child: Container(height: 30,width: 30,alignment: Alignment.center,
                                 decoration: BoxDecoration(shape: BoxShape.circle,color:  Colors.grey.shade300),
                                 child: Text("+",style: TextStyle(color: Colors.black,fontSize: 20),),
                               ),
                             ),
                       Container(height: 50,width: 50,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color:  Color(0xff9B99F5)),
                                 child:  Center(child: Text("${cartList[index].qty}",style: TextStyle(color: Colors.black,fontSize: 20),))
                               ),
                       GestureDetector(
                               onTap:  () {
                                 int tqty=cartList[index].qty!;

                                 if(tqty>1)
                                   {
                                     tqty--;
                                   }
                                 ProductModel model=ProductModel(
                                   name: cartList[index].name,
                                   price: cartList[index].price,
                                   qty: tqty,
                                   image: cartList[index].image,
                                   description: cartList[index].description,
                                   category: cartList[index].category,
                                   id: cartList[index].id
                                 );
                                FirebaseHelper.helper.updtacart(model);
                               },
                               child: Container(height: 30,width: 30,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:  Colors.grey.shade300),
                                 child: Center(child: Text("-",style: TextStyle(color: Colors.black,fontSize: 20))),

                               ),
                             ),
                     ],
                   ),
               ),
             );
           },itemCount: cartList.length,);

         }
         return Center(child: CircularProgressIndicator());
       },stream: FirebaseHelper.helper.readcartdata(),)

    ));
  }
}


class AddTOCartModel
{
  String? name,category,description,id,image;
  int? qty,price;

  AddTOCartModel(
      {this.price,
        this.qty,
      this.name,
      this.category,
      this.description,
      this.id,
      this.image});
}