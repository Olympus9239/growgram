import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:growgram/resources/auth_methods.dart';
import 'package:growgram/screens/login_screen.dart';
import 'package:growgram/utlis/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import '../utlis/utilis.dart';
import '../widgets/text_fields_input.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    final res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        userName: _userNameController.text,
        file: _image!);
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout())));
    }
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //svg
            SvgPicture.asset(
              'assets/images/insta.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            // circular widget to add profile picture
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundColor: primaryColor,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundColor: primaryColor,
                        backgroundImage: NetworkImage(
                            "https://image.shutterstock.com/image-vector/default-avatar-profile-social-media-260nw-1920331226.jpg"),
                      ),
                Positioned(
                  left: 80,
                  bottom: -10,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      selectImage();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //text field for email
            TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter your Email',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 24,
            ),

            // text field for password
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your Password',
              textInputType: TextInputType.phone,
              isPass: true,
            ),

            SizedBox(
              height: 24,
            ),
            // enter user name
            TextFieldInput(
              textEditingController: _userNameController,
              hintText: 'Enter UserName',
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
            ),
            // Enter bio
            TextFieldInput(
              textEditingController: _bioController,
              hintText: 'Enter your bio',
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 24,
            ),
            //button login
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),

            //Transistioning to singing up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: navigateToLogIn, child: Text("Sign In"))
              ],
            )
          ],
        ),
      )),
    );
    ;
  }
}
