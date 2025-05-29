import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:testing/boxes/boxes.dart';
import 'package:testing/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Hive Database"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, snapshot) {
            var data = box.values.toList().reversed.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Card(
                      color: Colors.deepPurple.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data[index].title.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    delete(data[index]);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    _editMyDialog(context, data[index],
                                        titleController, descriptionController);
                                  },
                                  child: Icon(Icons.edit),
                                ),
                              ],
                            ),
                            Text(
                              data[index].description.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog(context, titleController, descriptionController);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> _showMyDialog(
    dynamic context,
    TextEditingController titleController,
    TextEditingController descriptionController) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 100,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 5),
                        hintText: "Add a title of your note",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 5),
                        hintText: "Add a description ",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  final data = NotesModel(
                      title: titleController.text,
                      description: descriptionController.text);
                  final box = Boxes.getData();
                  box.add(data);
                  data.save();
                  titleController.clear();
                  descriptionController.clear();
                  print(box.values);
                  Navigator.pop(context);
                  print("done");
                },
                child: Text("Add")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      });
}

Future<void> _editMyDialog(
    dynamic context,
    NotesModel notesModel,
    TextEditingController titleController,
    TextEditingController descriptionController) async {
  titleController.text = notesModel.title.toString();
  descriptionController.text = notesModel.description.toString();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 100,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 5),
                        hintText: "Add a title of your note",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 5),
                        hintText: "Add a description ",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  notesModel.title = titleController.text;
                  notesModel.description = descriptionController.text;
                  notesModel.save();
                  Navigator.pop(context);
                  titleController.clear();
                  descriptionController.clear();
                },
                child: Text("Edit")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      });
}

delete(NotesModel notesModel) async {
  return await notesModel.delete();
}
