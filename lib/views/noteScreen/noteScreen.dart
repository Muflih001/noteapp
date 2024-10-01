import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({
    super.key,
    this.title = '',
    this.description = '',

    required this.onDelete,
    required this.onEdit,

  });
  final void Function()? onDelete;
  final void Function(String, String, Color?)? onEdit;
  late String title;
  late String description;


  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _isEditMode = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Color? _newColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);

  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
         Colors.amber[100]),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(118, 158, 158, 158),
                                borderRadius: BorderRadius.circular(30)),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 35,
                            ),
                          )),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_isEditMode) {
                                // Save the changes
                                widget.onEdit!(_titleController.text,
                                    _descriptionController.text, _newColor);
                                setState(() {
                                  widget.title = _titleController.text;
                                  widget.description =
                                      _descriptionController.text;
                             
                                  _isEditMode = false;
                                });
                              } else {
                                // Enter edit mode
                                setState(() {
                                  _isEditMode = true;
                                });
                              }
                            },
                            icon: Icon(_isEditMode ? Icons.save : Icons.edit),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isEditMode
                      ? SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            maxLines: null,
                            controller: _titleController,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        )
                      : Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: _isEditMode
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: TextFormField(
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Description',
                                      ),
                                      maxLines: null,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a description';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : Text(
                                    widget.description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 1,
              // left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      Row(
                        children: [
                        
                          IconButton(
                              onPressed: () {
                                Share.share(
                                    "${widget.title} \n${widget.description}");
                              },
                              icon: Container(child: Icon(Icons.share))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUI() {
    setState(() {});
  }
}
