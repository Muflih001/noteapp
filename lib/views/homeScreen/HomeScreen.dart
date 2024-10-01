import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:noteapp/views/homeScreen/widgets/noteCard.dart';
import 'package:noteapp/views/noteScreen/noteScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    super.key,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var noteBox = Hive.box('noteBox');
  List noteKeys = [];

  void deleteAllNotes() {
    noteBox.clear(); // Clear the Hive box
    noteKeys.clear(); // Clear the note keys list
    setState(() {}); // Update the UI
  }

  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.grey[800],
          onPressed: () {
            _titleController.clear();
            _descriptionController.clear();

            showModalBottomSheet(
              backgroundColor: Colors.grey[900],
              isScrollControlled: true,
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (context, setState) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2)),
                                      // focusedBorder: OutlineInputBorder(
                                      //     borderSide: BorderSide(color: Colors.black)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Title',
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 18),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minHeight: 50, maxHeight: 260),
                                  child: TextFormField(
                                    maxLines: null,
                                    controller: _descriptionController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a title';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.black, width: 2)),
                                        // contentPadding: EdgeInsets.symmetric(
                                        //     vertical: 30, horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Description',
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 18),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                              child: Text('Cancel')),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final title = _titleController.text;
                                            final description =
                                                _descriptionController.text;

                                            noteBox.add({
                                              "title": title,
                                              "description": description,
                                            });

                                            noteKeys = noteBox.keys.toList();

                                            Navigator.pop(context);
                                            _updateUI();
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child:
                                              const Center(child: Text('Save')),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            );
          },
          child: const Icon(
            Icons.edit_note_sharp,
            size: 30,
            color: Color.fromRGBO(230, 81, 0, 1),
          ),
        ),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                if (_scaffoldKey.currentState != null) {
                  _scaffoldKey.currentState!.openEndDrawer();
                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(139, 66, 66, 66),
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.black,
          title: Text(
            "My Notes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
            ),
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.grey[900],
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.delete),
                  title: Text('Delete All Notes'),
                  onTap: () {
                    // Handle logout tap
                    deleteAllNotes();
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0, top: 30, bottom: 30),
              //   child:
              // ),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 0),
                itemCount: noteKeys.length,
                itemBuilder: (context, index) {
                  final note = noteBox.get(noteKeys[index]);
                  return Dismissible(
                    key: Key(noteKeys[index].toString()),
                    direction: DismissDirection.startToEnd,
                    onUpdate: (details) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  NoteScreen(
                            onEdit: (newTitle, newDescription, newColor) {
                              // Update the note in the database or list
                              note['title'] = newTitle;
                              note['description'] = newDescription;

                              noteKeys = noteBox.keys.toList();
                              setState(() {}); // Update the UI
                              noteBox.put(noteKeys[index], note);
                            },
                            onDelete: () {
                              // Delete the note from the database or list
                              noteBox.delete(noteKeys[index]);
                              noteKeys = noteBox.keys.toList();
                              setState(() {}); // Update the UI
                            },
                            title: note['title'],
                            description: note['description'],
                          ),
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(-1, 0),
                                end: Offset(0, 0),
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: NoteCard(
                      onEdit: (newTitle, newDescription, newColor) {
                        // Update the note in the database or list
                        note['title'] = newTitle;
                        note['description'] = newDescription;

                        noteBox.put(noteKeys[index], note);
                        setState(() {}); // Update the UI
                      },
                      onDelete: () {
                        // Delete the note from the database or list
                        noteBox.delete(noteKeys[index]);
                        noteKeys = noteBox.keys.toList();
                        setState(() {}); // Update the UI
                      },
                      title: note['title'],
                      description: note['description'],
                    ),
                  );
                },
              )),
            ],
          ),
        ));
  }

  void _updateUI() {
    setState(() {});
  }
}
