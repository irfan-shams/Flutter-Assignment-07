import 'package:custom_login_signup/constants/app_colors.dart';
import 'package:custom_login_signup/constants/app_images.dart';
import 'package:custom_login_signup/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool? value = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool _isLoading = false; // Tracks loading state

  Future<void> registerUser(context) async {
    // Check if passwords match
    if (passController.text != confirmPassController.text) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: const Text('Passwords do not match.'),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; // Stop the registration process
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: const Text('User Registered Successfully...'),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      nameController.clear();
      emailController.clear();
      passController.clear();
      confirmPassController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use. Try logging in.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Use at least 6 characters.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
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
      nameController.clear();
      emailController.clear();
      passController.clear();
      confirmPassController.clear();
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
                    Image.asset(AppImages.signupImage),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Create Account!",
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
                  "Sign up to get started.",
                  style: TextStyle(
                    color: AppColors.greyTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Full Name Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textFieldBgColor,
                    prefixIcon: Icon(
                      Icons.person_outline,
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
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Email or Username Field
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
              // Password Field
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
              const SizedBox(height: 10),
              // Confirm Password Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: TextField(
                  obscureText: obscureConfirmPassword,
                  controller: confirmPassController,
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
                        obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
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
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.greenColor,
                      value: value,
                      onChanged: (bool? newValue) {
                        setState(() {
                          value = newValue;
                        });
                      },
                    ),
                    Text(
                      "Save Password",
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
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
                      await registerUser(context);
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // Show loading spinner
                        : Text(
                            "Register",
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
                      'By registering, you are agreeing with our',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
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
                      "Already have an account?",
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: Text(
                        "Log In",
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
