import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growgram/utlis/colors.dart';
import 'package:growgram/utlis/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page=0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController=PageController();
  
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  } 
  void navigationTapped(int page){
    _pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home,color: _page==0?primaryColor:secondaryColor,),
          backgroundColor: primaryColor,
          label: 'Home '
          ),
            BottomNavigationBarItem(icon: Icon(Icons.search
            ,color: _page==1?blueColor:secondaryColor,
            ),
          backgroundColor: primaryColor,
          label: 'Search '
          ),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2?primaryColor:secondaryColor,),
          backgroundColor: primaryColor,
          label: 'Home '
          ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _page==3?primaryColor:secondaryColor,),
          backgroundColor: primaryColor,
          label: 'Favourite '
          ),
            BottomNavigationBarItem(icon: Icon(Icons.person,color: _page==4?primaryColor:secondaryColor,),
          backgroundColor: primaryColor,
          label: 'Person '
          ),
          
        ],
        onTap: navigationTapped,
        ),
      body: PageView(
        children: homeScreenItems,
          

        
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      onPageChanged:onPageChanged,
      ),
      );
    
  }
}
