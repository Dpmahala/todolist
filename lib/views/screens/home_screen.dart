import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/todo_controller.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/utils/utils.dart';
import 'package:todolist/views/screens/add_new_task.dart';
import 'package:todolist/widgets/my_text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoController todoController = Get.put(TodoController());
  // int selectedPriority = 1;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  var index = 1;
  bool isSelected = false;
  String selectedOrder = "Priority";
  int? selectedItem;
  List selectedIndex = [];

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
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
          backgroundColor: AppColors.AppBarColor,
          elevation: 0,
          title: const Text(
            "ToDo List",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              TextField(
                onChanged: (value) {
                  todoController.searchToDo(value);
                },
                decoration: InputDecoration(
                  fillColor: AppColors.TextFieldColor,
                  filled: true,
                  hintText: "Search todos...",
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
                height: 10.h,
              ),
              Center(
                child: Text(
                  "All ToDos",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black.withOpacity(.7),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    // value: selectedOrder!,
                    padding: EdgeInsets.all(0),
                    items: [
                      DropdownMenuItem(
                        child: Text("Priority"),
                        value: 'Priority',
                      ),
                      DropdownMenuItem(
                        child: Text("Date Time"),
                        value: 'DateTime',
                      ),
                      DropdownMenuItem(
                        child: Text("Create Time"),
                        value: 'CreateTime',
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedOrder = value!;
                          todoController.setSortOrder(value);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                    ),
                    hint: Text(
                      "$selectedOrder",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddNewTask(), transition: Transition.fade);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.h),
                      decoration: BoxDecoration(
                          color: AppColors.buttonsColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: const Text(
                        "Add New",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Obx(() {
                  if (todoController.searchResult.isEmpty) {
                    return Center(
                      child: Text(
                        "No todos",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: todoController.searchResult.length,
                      itemBuilder: (context, index) {
                        final todo = todoController.searchResult[index];
                        int indexCount = index + 1;
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          margin: EdgeInsets.symmetric(vertical: 5.h),
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
                                    radius: 10.r, child: Text("$indexCount")),

                                Checkbox(
                                    checkColor: Colors.yellow,
                                    value: todo.isCompleted,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        selectedItem = index;

                                        final updateTodo = ToDo(
                                            title: todo.title,
                                            dateTime: todo.dateTime,
                                            desc: todo.desc,
                                            createTime: todo.createTime,
                                            isCompleted: value!,
                                            priority: todo.priority);
                                        todoController.updateTodo(
                                            index, updateTodo);
                                      });
                                    }),
                                // SizedBox(
                                //   width: 8.w,
                                // ),

                                Container(
                                  width: 100.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        todo.title,
                                        style: TextStyle(
                                          decoration: !todo.isCompleted
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        todo.desc,
                                        style: TextStyle(
                                            decoration: !todo.isCompleted
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough,
                                            color:
                                                Colors.black.withOpacity(.6)),
                                      ),
                                    ],
                                  ),
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
                                        " ${todo.dateTime.hour}:${todo.dateTime.minute}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.black.withOpacity(.5)),
                                      ),
                                      Text(
                                        '${todo.dateTime.day}/${todo.dateTime.month}/${todo.dateTime.year}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.black.withOpacity(.3)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    todoController.deleteToDo(index, todo);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Task Delete"),
                                    ));
                                  },
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
                                  onTap: () {
                                    showbottomSheet(context, index, todo);
                                  },
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
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showbottomSheet(BuildContext context, int index, ToDo todo) {
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descController =
        TextEditingController(text: todo.desc);

    DateTime? selectedDateTime = todo.dateTime;
    int selectedPriority = todo.priority;

    TimeOfDay? selectedTime = TimeOfDay.fromDateTime(todo.dateTime);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                MyTextField(
                  hintText: 'Title',
                  controller: TextEditingController(text: todo.title),
                  onChanged: (value) {
                    todo.title = value;
                  },
                ),
                SizedBox(height: 10.h),
                MyTextField(
                  hintText: 'Description',
                  initialValue: todo.desc,
                  controller: TextEditingController(text: todo.desc),
                  onChanged: (value) {
                    todo.desc = value;
                  },
                ),
                SizedBox(height: 10.h),
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
                                initialDate: selectedDateTime ?? todo.dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null &&
                                  picked != selectedDateTime) {
                                setState(() {
                                  selectedDateTime = picked;
                                  todo.dateTime = picked;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                          ),
                          Text(selectedDateTime != null
                              ? "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year}"
                              : "${todo.dateTime.day}/${todo.dateTime.month}/${todo.dateTime.year}"),
                          SizedBox(width: 4.w),
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
                            todo.priority = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
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
                                initialTime: selectedTime ??
                                    TimeOfDay.fromDateTime(todo.dateTime),
                              );
                              if (picked != null) {
                                setState(() {
                                  selectedTime = picked;
                                  todo.dateTime = DateTime(
                                    todo.dateTime.year,
                                    todo.dateTime.month,
                                    todo.dateTime.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                });
                              }
                            },
                            icon: const Icon(Icons.access_time),
                          ),
                          Text(selectedTime != null
                              ? "${selectedTime!.hour}:${selectedTime!.minute}"
                              : "${todo.dateTime.hour}:${todo.dateTime.minute}"),
                          SizedBox(width: 4.w),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          todoController.updateTodo(index, todo);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Your Task is updated"),
                          ));
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                              color: AppColors.buttonsColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                              color: AppColors.buttonsColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
