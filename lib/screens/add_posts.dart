import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growgram/providers/user_provider.dart';
import 'package:growgram/resources/firestore_methods.dart';
import 'package:growgram/utlis/utilis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String userName,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        userName,
        profImage,
      );
      if (res == 'sucess') {
        showSnackBar('Posted!', context);
        setState(() {
          _isLoading = false;
        });
      } else {
        showSnackBar(res, context);
        clearImage();
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
 void clearImage()async{
    setState(() {
      _file=null;
    });
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
            onPressed: (() => _selectImage(context)),
            icon: Icon(Icons.upload),
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text('Add Post'),
              centerTitle: false,
              leading: IconButton(
                onPressed: clearImage,
                 
                
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                TextButton(
                    onPressed: (() =>
                        postImage(user.uid, user.userName, user.photoUrl)),
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'What\'s on your mind .....',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          )),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
