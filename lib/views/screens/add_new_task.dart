import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/todo_controller.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/service/notification_service.dart';
import 'package:todolist/utils/utils.dart';
import 'package:todolist/views/screens/home_screen.dart';
import 'package:todolist/widgets/my_text_field.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TodoController todoController = Get.find();

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  int selectedPriority = 1;

  DateTime? selectedDateTime;

  TimeOfDay? selectedTime;

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.flutterLocalNotificationsPlugin;
  }

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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          title: const Text(
            "Add New Task",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            width: double.infinity,
            // height: ScreenUtil().screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                MyTextField(hintText: "Title", controller: titleController),
                SizedBox(
                  height: 20.h,
                ),
                MyTextField(
                    hintText: "Description", controller: descController),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Color(0xffEBEFF2),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      selectedDateTime ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));
                              if (picked != null &&
                                  picked != selectedDateTime) {
                                setState(() {
                                  selectedDateTime = picked;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                          ),
                          Text(selectedDateTime != null
                              ? "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year}"
                              : "Select Date"),
                          SizedBox(
                            width: 4.w,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white,
                      ),
                      child: DropdownButton<int>(
                          borderRadius: BorderRadius.circular(5.r),
                          value: selectedPriority,
                          items: [
                            DropdownMenuItem(
                              child: Text("Low"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Mid"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("High"),
                              value: 3,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value!;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Color(0xffEBEFF2),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  selectedTime = picked;
                                });
                              }
                            },
                            icon: const Icon(Icons.access_time),
                          ),
                          Text(selectedTime != null
                              ? "${selectedTime!.hour}:${selectedTime!.minute}"
                              : "Select Time"),
                          SizedBox(
                            width: 4.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAll(HomeScreen(), transition: Transition.fade);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: AppColors.buttonsColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addNewTask();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.buttonsColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
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
    );
  }

  void addNewTask() {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      DateTime? dateTime;
      if (selectedDateTime != null && selectedTime != null) {
        dateTime = DateTime(
          selectedDateTime!.year,
          selectedDateTime!.month,
          selectedDateTime!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );
      } else if (selectedDateTime != null) {
        dateTime = DateTime(
          selectedDateTime!.year,
          selectedDateTime!.month,
          selectedDateTime!.day,
        );
      } else {
        dateTime = DateTime.now();
      }

      ToDo newTodo = ToDo(
        title: titleController.text,
        desc: descController.text,
        isCompleted: false,
        dateTime: dateTime!,
        priority: selectedPriority,
        createTime: DateTime.now(),
      );

      todoController.addToDo(newTodo);
      notificationService.showNotification(
          id: 0, title: "New Task", body: "New task added");
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("New Task Added")));
      Get.offAll(HomeScreen());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all the fields")));
    }
  }
}
