import 'package:custom_login_signup/constants/app_colors.dart';
import 'package:custom_login_signup/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: AppColors.greenColor,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.greenColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Text(
              user.email!,
              style: TextStyle(
                color: AppColors.greenColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
