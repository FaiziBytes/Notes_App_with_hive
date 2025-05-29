import "package:hive/hive.dart";
import "package:testing/models/notes_model.dart";

// class Boxes {
//   static Box<NotesModel> getData() => Hive.box<NotesModel>("notes");
// }

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>("notes");
}
