import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist/views/screens/add_new_task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.yellow,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Get.to(AddNewTask());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffEBEFF2).withOpacity(.5),
          elevation: 0,
          title: const Text(
            "ToDo List",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: const Color(0xffEBEFF2),
                  filled: true,
                  hintText: "Search Something...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "All ToDos",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(.7),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 8.w, right: 3.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Text(
                                  "$index",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Description",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.6)),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(2.r)),
                                child: Column(
                                  children: [
                                    Text(
                                      "05:00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    Text(
                                      "22/05/2024",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(.3)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
