import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers_user/user/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
 static final helper = FirebaseHelper._();

 FirebaseHelper._();

 String? uid;
 int qty=1;

 FirebaseAuth auth = FirebaseAuth.instance;
 FirebaseFirestore firestore = FirebaseFirestore.instance;

 Future<String> load() async {
  try {
   await auth.signInAnonymously();

   return 'success';

  }
  catch (e) {
   return 'faild';
  }
 }

 bool chakuser() {
  User? user = auth.currentUser;
  return user != null;
 }

 Future<String> createUser(String email, String password) async {
  try {
   await auth.createUserWithEmailAndPassword(email: email, password: password);
   return 'success';
  } catch (e) {
   return '$e';
  }
 }

 Future<String> signIn(String email, String password) async {
  try {
   await auth.signInWithEmailAndPassword(email: email, password: password);
   return 'success';
  } catch (e) {
   return '$e';
  }
 }

 Future<String> googleSignIn() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
   accessToken: googleAuth?.accessToken,
   idToken: googleAuth?.idToken,
  );
  try {
   await auth.signInWithCredential(credential);
   return "succes";
  } catch (e) {
   return "$e";
  }
 }


 Map<String, String?> userditailes() {
  User? user = auth.currentUser;
  var email = user!.email;
  var name = user.displayName;
  var number = user.phoneNumber;
  var photo = user.photoURL;
  uid = user.uid;
   print("=============================================================================${uid}================================");
  return {"email": email, "name": name, "number": number, "photo": photo};
 }

 Stream<QuerySnapshot<Map<String, dynamic>>> readProduct() {
  return firestore.collection('Product').snapshots();
 }

 void addcart(ProductModel model) {
  firestore.collection('Cart').doc('$uid').collection('Product').add(
      {
       "name": model.name,
       "price": model.price,
       "image": model.image,
       "category": model.category,
       "description": model.description,
       "qty":model.qty
      }
  );
 }

 Stream<QuerySnapshot<Map<String, dynamic>>> readcartdata()
 {
  return firestore.collection('Cart').doc('$uid').collection('Product').snapshots();
 }

 void updtacart(ProductModel model)
 {
  firestore.collection("Cart").doc('$uid').collection('Product').doc(model.id).set({
   "name": model.name,
   "price":model.price,
   "image":model.image,
   "category":model.category,
   "description":model.description,
   "qty":model.qty
  });
 }
 
}