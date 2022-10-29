import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:growgram/providers/user_provider.dart';
import 'package:growgram/responsive/mobile_screen_layout.dart';
import 'package:growgram/responsive/responsive.dart';
import 'package:growgram/responsive/web_screen_layout.dart';
import 'package:growgram/screens/login_screen.dart';
import 'package:growgram/screens/sign_up_screen.dart';
import 'package:growgram/utlis/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAqSxqf30f4Do7jH5FTQzpGFN8NZbPq5nY",
        appId: "1:826669629383:web:163c689fa1ad6d43f2a3e2",
        messagingSenderId: "826669629383",
        storageBucket: "growgram-95d5e.appspot.com",
        projectId: "growgram-95d5e",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GrowGram",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              }
              return LoginScreen();
            }),
      ),
    );

    //const  ResponsiveLayout(mobileScreenLayout:MobileScreenLayout() ,webScreenLayout:WebScreenLayout() ,
    //  ),
  }
}
