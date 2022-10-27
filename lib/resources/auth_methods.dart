import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:growgram/models/user.dart' as model;
import 'package:growgram/resources/storage_methods.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  // sign up user
 
Future<String>   signUpUser({
   required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
 })
  async{
    String res="Some error Occured";
    try{
      if(email.isNotEmpty|| password.isNotEmpty || bio.isNotEmpty || userName.isNotEmpty || file.isNotEmpty ){
       // register user
       UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
       print(cred.user!.uid);
      
        //adding image to firebase storage 
      String photoUrl= await StorageMethods().uploadImagetoStorage('profilePics', file, false);

       // add User to Firestore database
       model.User user=model.User(
        followers: [],
        following: [],
         uid: cred.user!.uid,
         email: email,
         userName: userName,
         bio: bio,
         photoUrl: photoUrl,
       );
       await  _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
       // we use this when we dont use model class and use sset directly
    //   await  _firestore.collection('users').doc(cred.user!.uid).set({
    //      'email':email,
    //      'userName':userName,
    //      'bio':bio,
    //      'uid':cred.user!.uid,
    //  'photoUrl':photoUrl,
    //   'followers':[],
    //   'following':[],
    //    });
       // we this to directly add
      //  await _firestore.collection('users').add(
      //     {
      //       'email':email,
      //       'userName':userName,
      //       'bio':bio,
      //       'uid':cred.user!.uid,
      //     //   'profileImage':file,
      //     'followers':[],
      //     'following':[],
      //     }
      //   );
       

       res='success'; 
      
      }
    }
    catch(e){
      res=e.toString();
    }
   return res;
 }

 Future<String> loginUser({
  required String email,
  required String password,
 })async{
  String res='Some error occured';
  try{
    if(email.isNotEmpty || password.isNotEmpty){
      UserCredential cred=await _auth.signInWithEmailAndPassword(email: email, password: password);
      res='success';
    }else{
      res="Please fill all the fields";
    }
  }
  catch(e){
    res=e.toString();
  }
  return res; 
 }
}