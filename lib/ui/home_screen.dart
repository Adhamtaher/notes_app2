import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app2/core/color_manager.dart';
import 'package:notes_app2/logic/create_note/bloc.dart';
import 'package:notes_app2/logic/get_note/bloc.dart';
import 'package:notes_app2/logic/get_note/event.dart';
import 'package:notes_app2/logic/get_note/state.dart';
import 'package:notes_app2/model/Notes.dart';
import 'package:notes_app2/ui/note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(DisplayNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, GetNoteStates>(
      builder: (context, state) {
        if (state is GetNoteLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetNoteLoadedState) {
          final notes = state.notes;
          return Scaffold(
            backgroundColor: ColorManager.primaryColor,
            body: Padding(
              padding: const EdgeInsets.only(top: 135, left: 25, right: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) => CreateNoteBloc(),
                                child: NoteScreen(),
                              ),
                            ),
                          );
                          context.read<NoteBloc>().add(DisplayNoteEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 65,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Add note",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 65,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Log out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        final DateTime date = note.createdAt.toDate();
                        final time = DateFormat('h.mm a').format(date).toLowerCase();
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => CreateNoteBloc(),
                                  child: NoteScreen(existingNote: note, noteId: note.id!,),
                                ),
                              ),
                            );
                            context.read<NoteBloc>().add(DisplayNoteEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorManager.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.headline,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              note.description,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              time,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: (){
                                          context.read<NoteBloc>().add(DeleteNoteEvent(noteId: note.id!));
                                        },
                                        child: Icon(Icons.delete, size: 20, color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is GetNoteErrorState) {
          return Center(child: Text(state.error));
        } else {
          return SizedBox();
        }
      },
    );
  }
}
