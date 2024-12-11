import 'package:creature_care/components/custom_button.dart';
import 'package:creature_care/components/input_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  
  void signUserIn() async {
    // Show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });

    // try to sign the user in
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text,
  password: passwordController.text,
  );
  
    // Get rid of loading circle
    Navigator.pop(context);
} on FirebaseAuthException catch (e) {
  // Get rid of loading circle
  Navigator.pop(context);
  // TODO
  if (e.code == 'invalid-email') {
    debugPrint('No username with this email');
    wrongEmailMessage();
  } else if (e.code == 'wrong-password') {
    debugPrint('Wrong password');
    wrongPasswordMessage();
  } else if (e.code == 'user-not-found') {
    userNotFoundMessage();
  } else if (e.code == 'user-disabled') {
    disabledUserMessage();
  }
}

// RESUME AT
// https://youtu.be/4fucdtPwTWI?feature=shared&t=1769

  }

  // Display wrong email message
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(title: Text("Incorrect Email"),
          ),
        ); 
      },
    );
  }

    // Display wrong password message
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(title: Text("Incorrect Password"),
          ),
        ); 
      },
    );
  }

      // Display disabled user message
  void disabledUserMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(title: Text("User Disabled"),
          ),
        ); 
      },
    );
  }

      // Display user not found message
  void userNotFoundMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(title: Text("User Not Found"),
          ),
        ); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                SizedBox(height: 50),
              // logo?
              Icon(
                Icons.lock,
                size: 100,
              ),
            
              SizedBox(height: 50),
              Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),),
              // username textfield
              InputTextfield(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),
            
              // password textfield
              InputTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,

              ),
            
              // forgot password?
            
            
              // sign-in button
              CustomButton(
                content: "SIGN IN",
                onTap: signUserIn),
            
              // or continue with...
            
              // register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Register", style: TextStyle(color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold),),
                  ),
                ]
              ),
            
            ],),
          ),
        ),
      ),
    );
  }
}