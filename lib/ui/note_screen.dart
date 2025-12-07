import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app2/core/color_manager.dart';
import 'package:notes_app2/logic/create_note/bloc.dart';
import 'package:notes_app2/logic/create_note/event.dart';
import 'package:notes_app2/logic/create_note/state.dart';
import 'package:notes_app2/model/Notes.dart';

class NoteScreen extends StatefulWidget {
  final Note? existingNote;
  final String? noteId;

  const NoteScreen({super.key, this.existingNote, this.noteId});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController headLineController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      headLineController.text = widget.existingNote!.headline;
      descriptionController.text = widget.existingNote!.description;
    }
  }

  void _submitNote() {
    if (headLineController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }
    final note = Note(
      headline: headLineController.text,
      description: descriptionController.text,
      createdAt: widget.existingNote?.createdAt ?? Timestamp.now(),
    );
    if(widget.existingNote != null && widget.noteId != null){
      context.read<CreateNoteBloc>().add(EditNoteEvent(note, widget.noteId!));
    }else{
      context.read<CreateNoteBloc>().add(SubmitNoteEvent(note));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateNoteBloc, CreateNoteStates>(
      listener: (context, state) {
        if(state is CreateNoteLoadedState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.existingNote != null ? 'Note was updated successfully' : 'Note was created successfully')));
          Navigator.pop(context);
        }else if(state is CreateNoteErrorState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ${state.error}')));
        }

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.primaryColor,
          body: Padding(
            padding: EdgeInsets.only(top: 135, left: 45, right: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Create new note",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  " Title",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: headLineController,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Enter note title",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                    filled: true,
                    fillColor: ColorManager.secondaryColor,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  " Description",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: descriptionController,
                  minLines: 6,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Enter Your description",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                    filled: true,
                    fillColor: ColorManager.secondaryColor,
                  ),
                ),
                SizedBox(height: 250),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Select media",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _submitNote,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.existingNote == null ? 'Create note' : 'Edit note',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
