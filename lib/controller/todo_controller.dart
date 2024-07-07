import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolist/models/todo.dart';

class TodoController extends GetxController {
  var todoList = <ToDo>[].obs;
  var searchResult = <ToDo>[].obs;
  var sortBy = "createTime".obs;
  late Box<ToDo> _todoBox;
  RxInt selectedPriority = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _openBox();
    ToDos();
  }

  @override
  void onClose() {
    _closeBox();
    super.onClose();
  }

  void _openBox() {
    _todoBox = Hive.box<ToDo>("todoBox");
  }

  void _closeBox() {
    if (_todoBox.isOpen) {
      _todoBox.close();
    }
  }

  void ToDos() {
    final box = Hive.box<ToDo>("todoBox");
    todoList.value = box.values.toList();
    searchResult.value = List<ToDo>.from(todoList);
  }

  void addToDo(ToDo todo) {
    final box = Hive.box<ToDo>("todoBox");
    box.add(todo);
    todoList.add(todo);
    searchResult.add(todo);
    ToDos();
  }

  void updateTodo(int index, ToDo todo) {
    final box = Hive.box<ToDo>("todoBox");
    box.putAt(index, todo);
    todoList[index] = todo;
    searchResult[index] = todo;
    ToDos();
  }

  void deleteToDo(int index, ToDo todo) {
    final box = Hive.box<ToDo>("todoBox");
    box.deleteAt(index);
    todoList.removeAt(index);
    searchResult.removeAt(index);
    ToDos();
  }

  void setSelectedPriority(int priority) {
    selectedPriority.value = priority;
  }

  void searchToDo(String query) {
    if (query.isEmpty) {
      searchResult.value = todoList;
    } else {
      searchResult.value = todoList
          .where((todo) =>
              todo.title.toLowerCase().contains(query.toLowerCase()) ||
              todo.desc.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void sortTodo() {
    switch (sortBy.value) {
      case 'priority':
        searchResult.sort((a, b) => b.priority.compareTo(a.priority));

        break;

      case "dateTime":
        searchResult.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        break;

      case "createTime":
        searchResult.sort((a, b) => a.createTime.compareTo(b.createTime));
        break;
    }
  }

  void setSortOrder(String order) {
    sortBy.value = order;
    ToDos();
  }
}
