// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo(
      title: fields[0] as String,
      desc: fields[1] as String,
      isCompleted: fields[2] as bool,
      dateTime: fields[3] as DateTime,
      priority: fields[4] as int,
      createTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
