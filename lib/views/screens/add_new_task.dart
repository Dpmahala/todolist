import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist/views/screens/home_screen.dart';
import 'package:todolist/widgets/my_text_field.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              MyTextField(hintText: "email", controller: emailController),
              SizedBox(
                height: 20.h,
              ),
              MyTextField(hintText: "email", controller: nameController),
              SizedBox(
                height: 20.h,
              ),
              MyTextField(hintText: "email", controller: phoneController),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(const HomeScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.yellow,
                              Colors.blueAccent,
                            ]),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Text(
                        "Cancle",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.yellow,
                            Colors.blueAccent,
                          ]),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
