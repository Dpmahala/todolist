import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/service/notification_service.dart';
import 'package:todolist/views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>("todoBox");
  if (!Hive.isBoxOpen("todoBox")) {
    await Hive.openBox<ToDo>("todoBox");
    await NotificationService().flutterLocalNotificationsPlugin;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => GetMaterialApp(
        title: 'ToDo List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
