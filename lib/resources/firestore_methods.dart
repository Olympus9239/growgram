import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:growgram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/posts.dart';

class FirestoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String userName,
    String profImage,
  ) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImagetoStorage('posts', file, true);
      String postid = Uuid().v1();
      Post post = Post(
          description: description,
          datePublished: DateTime.now(),
          userName: userName,
          postId: postid,
          postUrl: photoUrl,
          profImage: profImage,
          uid: uid,
          likes: null);
          _fireStore.collection('posts').doc(postid).set(post.toJson());
          res='success';
    } catch (e) {
      res=e.toString();
    }
    return res;
  }
}
