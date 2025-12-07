import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app2/logic/get_note/event.dart';
import 'package:notes_app2/logic/get_note/state.dart';
import 'package:notes_app2/model/Notes.dart';

class NoteBloc extends Bloc<GetNoteEvent, GetNoteStates> {
  NoteBloc() : super(GetNoteInitialState()) {
    on<DisplayNoteEvent>((event, emit) async {
      emit(GetNoteLoadingState());
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("notes")
            .get();
        final notes = snapshot.docs
            .map((doc) => Note.fromJson(doc.data(), doc.id))
            .toList();
        emit(GetNoteLoadedState(notes));
      } catch (e) {
        emit(GetNoteErrorState(e.toString()));
      }
    });
    on<DeleteNoteEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(event.noteId)
            .delete();

        add(DisplayNoteEvent());
      } catch (e) {
        emit(GetNoteErrorState(e.toString()));
      }
    });
  }
}
