import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String desc;

  @HiveField(2)
  late bool isCompleted;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late int priority;

  @HiveField(5)
  late DateTime createTime;

  @HiveField(6)
  late DateTime? reminderTime;
  @HiveField(7)
  late int id;

  ToDo({
    required this.title,
    required this.desc,
    required this.isCompleted,
    required this.dateTime,
    required this.priority,
    required this.createTime,
    this.reminderTime,
  });
}
