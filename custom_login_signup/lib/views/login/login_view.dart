import 'package:flutter/material.dart';
import 'package:custom_login_signup/constants/app_images.dart';
import 'package:custom_login_signup/constants/app_colors.dart';
import 'package:custom_login_signup/views/login/home_view.dart';
import 'package:custom_login_signup/views/login/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool? value = true;
  bool obscurePassword = true;
  bool _isLoading = false; // Tracks loading state

  Future<void> login(context) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
      // final snackBar = SnackBar(
      //   backgroundColor: Colors.green,
      //   content: const Text('User Login Successfully...'),
      //   action: SnackBarAction(
      //     label: '',
      //     onPressed: () {},
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (e) {
      // print(e);
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled. Contact support.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Try again later.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Check your connection and try again.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMessage),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emailController.clear();
      passController.clear();
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Positioned(
                      top: -165,
                      right: -140,
                      child: Container(
                        width: 400,
                        height: 400,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greenCircleColor,
                        ),
                      ),
                    ),
                    Image.asset(AppImages.loginImage),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Enter your credentials to continue.",
                  style: TextStyle(
                    color: AppColors.greyTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textFieldBgColor,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 18,
                      color: AppColors.textFieldIconColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFieldBorderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.greenColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: TextField(
                  obscureText: obscurePassword,
                  controller: passController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textFieldBgColor,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 18,
                      color: AppColors.textFieldIconColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        size: 18,
                        color: AppColors.greenColor,
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.textFieldBorderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.greenColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await login(context);
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // Show loading spinner
                        : Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'By logging, you are agreeing with our',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Terms of Use",
                            style: TextStyle(
                              color: AppColors.greenColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.greenColor,
                            ),
                          ),
                        ),
                        Text(
                          ' and ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.greyTextColor,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: AppColors.greenColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreenColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: AppColors.greenColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
