import 'package:datahex/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:datahex/colors/app_colors.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryGreen,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      top: 7.h,
                      bottom: 0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                              color: Colors.black,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(height: 1.2.h),
                          Text(
                            'Please enter the details\nbelow to continue',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 15.sp,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          _RoundedTextField(
                            controller: emailCtrl,
                            hint: 'Email ID',
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 2.h),
                          _RoundedTextField(
                            controller: passCtrl,
                            hint: 'Password',
                            icon: Icons.lock_outline,
                            obscure: obscure,
                            suffix: IconButton(
                              icon: Icon(
                                obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                                color: AppColors.textGrey,
                              ),
                              onPressed:
                                  () => setState(() => obscure = !obscure),
                            ),
                          ),
                          SizedBox(height: 3.5.h),
                          Container(
                            height: 6.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.sp),
                                ),
                                backgroundColor: AppColors.accentGreen,
                                elevation: 0,
                              ),
                              onPressed: () {
                                LoginController.loginUser(
                                  context: context,
                                  email: emailCtrl.text,
                                  password: passCtrl.text,
                                );
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.5.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 15.5.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: AppColors.signUpBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.5.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;

  const _RoundedTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: AppColors.fieldBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20.sp),
          suffixIcon: suffix,
          filled: true,
          fillColor: AppColors.fieldFill,
          contentPadding: EdgeInsets.symmetric(
            vertical: 2.2.h,
            horizontal: 4.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }
}
