import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
    final  datePublished;

  final String userName;

  final String postId;

final String postUrl;
final String profImage; 
  final String uid;
  final likes;



  Post({
    required this.description,
    required this.datePublished,
    required this.userName,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.uid, 
    required this.likes,
    
  });
  Map<String,dynamic> toJson()=>{
    'description':description,
    'datePublished':datePublished,
    'userName':userName,
    'postId':postId,
    'postUrl':postUrl,
    'profImage':profImage,
    'uid':uid,
  };
// using this function we are taking in document snapshot and returing a user model
 
  static Post fromSnap(DocumentSnapshot snap){
     var snapshot=snap.data() as Map<String,dynamic>;
     return Post(
       
       description: snapshot['description'],
       datePublished: snapshot['datePublished'],
       userName: snapshot['userName'],
       postId: snapshot['postId'],
       postUrl: snapshot['postUrl'],
       profImage: snapshot['profImage'],
       uid: snapshot['uid'],
        likes: snapshot['likes'],
       
     );
  }
  
  

}