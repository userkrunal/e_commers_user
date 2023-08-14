import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers_user/user/controller/product_controller.dart';
import 'package:e_commers_user/user/firebase_helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: 320,
            width: 100.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/img_4.png"),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 30, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Find the best",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 30),
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed('/addtocart');
                            },
                            icon: Icon(
                              Icons.add_shopping_cart_rounded,
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 175),
                  child: Text(
                    "Furniture!🛋️",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 7.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black),
                        child: Center(child: Text("\$299",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),)),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(height: 6.h,width: 13.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),color: Colors.white),
                          child: Icon(Icons.favorite_outline_outlined,size: 30,color:Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 8.h,
              width: 100.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(23),color: Colors.black),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.search,color: Colors.white70,size: 35,),
                  SizedBox(width: 20),
                  Text("Search items",style: TextStyle(fontSize: 20,color: Colors.white54),),
                  Spacer(),
                  Container(height: 7.h,width: 17.w,
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xffCDE9D4)) ,
                    child: Icon(Icons.filter_list_alt),
                  ),

                  SizedBox(width: 10),

                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseHelper.helper.readProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot qs = snapshot.data!;
                List<QueryDocumentSnapshot> qList = qs.docs;

                Map m1 = {};
                // List<ProductModel> productList = [];

                controller.productList.clear();
                for (var x in qList) {
                  m1 = x.data() as Map;
                  String id = x.id;
                  String name = m1['name'];
                  String category = m1['category'];
                  int price = m1['price'];
                  String image = m1['image'];
                  String description = m1['description'];
                  ProductModel model = ProductModel(
                      price: price,
                      name: name,
                      category: category,
                      description: description,
                      id: id,
                      image: image);
                  controller.productList.add(model);
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 220),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/data', arguments: index);
                          },
                          child: Container(
                            height: 320,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xffEDEDED)),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                ),
                                Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(controller
                                                      .productList[index]
                                                      .image !=
                                                  null
                                              ? "${controller.productList[index].image}"
                                              : "https://m.media-amazon.com/images/I/71lG7br7k1L._SX679_.jpg"),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${controller.productList[index].name}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "\$ ${controller.productList[index].price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                //
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.productList.length,
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          SizedBox(height: 10)
        ],
      ),
    ));
  }
}

class ProductModel {
  String? name, category, description, id, image;
  int? qty,price;

  ProductModel(
      {this.price,
        this.qty,
      this.name,
      this.category,
      this.description,
      this.id,
      this.image});
}
