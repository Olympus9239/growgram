import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growgram/resources/auth_methods.dart';
import 'package:growgram/screens/sign_up_screen.dart';
import 'package:growgram/utlis/colors.dart';
import 'package:growgram/widgets/text_fields_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import '../utlis/utilis.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
        if(res=='success'){
          //
          showSnackBar("Login Done", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout()
         
          )));
        }else{
          showSnackBar(res, context);
        }
        setState(() {
          isLoading=false;
        
        });
  }
 void navigateToSignUp(){
 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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
            //button login
            InkWell(
              onTap: loginUser,
              child: Container(
                child: isLoading?Center(child: CircularProgressIndicator(color: Colors.white),):Text("Login"),
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
                Text("Don't have an account?"),
                TextButton(
                    onPressed:navigateToSignUp,
                    
                    child: Text("Sign Up"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
