import 'package:creature_care/components/custom_button.dart';
import 'package:creature_care/components/input_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget{
  final Function()? onTap;
  Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    // Show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });

    // try to sign the user up
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // Get rid of loading circle
        Navigator.pop(context);
         // show error message
         nonMatchingPasswords();
      }
  
} on FirebaseAuthException catch (e) {
  // Get rid of loading circle
  Navigator.pop(context);
  // TODO
  if (e.code == 'invalid-email') {
    debugPrint('No user with this email');
    wrongEmailMessage();
  } else if (e.code == 'wrong-password') {
    debugPrint('Wrong password');
    wrongPasswordMessage();
  } else if (e.code == 'user-not-found') {
    userNotFoundMessage();
  } else if (e.code == 'user-disabled') {
    disabledUserMessage();
  }
} finally {
  Navigator.pop(context);
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

  void nonMatchingPasswords() {
     showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(title: Text("Passwords don't match!"),
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
                "REGISTER",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),),
                
              // Email textfield
              InputTextfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
            
              // password textfield
              InputTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              // Confirm password textfield
              InputTextfield(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
            
              // forgot password?
            
            
              // sign-in button
              CustomButton(
                content: "CREATE ACCOUNT",
                onTap: signUserUp),
            
              // or continue with...
            
              // login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ', 
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Login", style: TextStyle(color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            
            ],),
          ),
        ),
      ),
    );
  }
}