import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = '';
  @override
  void initState() {
    // TODO: implement initState
    // we are using init state so that we can show name at first before we type/do  anything in the app
    // also we will be using Firebase which will give a future but if we use async await in init state it gives error
    // thats why we are making a new function
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance 
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
      // print(snap.data());
      setState(() {
        username = (snap.data() as Map<String,dynamic>)['userName'];
      
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            FirebaseAuth.instance.signOut();

          
          },
          child: Text('$username')),
      ),
    );
  }
}
