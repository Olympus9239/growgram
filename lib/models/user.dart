class User{
  final String email;
    final String photoUrl;

  final String userName;

  final String bio;

final List followers;
final List following; 
  final String uid;

  User({
    required this.email,
    required this.photoUrl,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
    required this.uid,
  });
  Map<String,dynamic> toJson()=>{
    'email':email,
    'photoUrl':photoUrl,
    'userName':userName,
    'bio':bio,
    'followers':followers,
    'following':following,
    'uid':uid,
  };
  


  // factory User.fromDocument(DocumentSnapshot doc){
  //   return User(
  //     email: doc['email'],
  //     photoUrl: doc['photoUrl'],
  //     username: doc['userName'],
  //     bio: doc['bio'],
  //     followers: doc['followers'],
  //     following: doc['following'],
  //     uid: doc['uid'],
  //   );
  // }

}