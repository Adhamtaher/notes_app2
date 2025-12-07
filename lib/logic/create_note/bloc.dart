import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app2/logic/create_note/event.dart';
import 'package:notes_app2/logic/create_note/state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteStates> {
  CreateNoteBloc() : super(CreateNoteInitialState()) {
    on<SubmitNoteEvent>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection("notes")
            .add(event.note.toJson());
        emit(CreateNoteLoadedState());
      } catch (e) {
        emit(CreateNoteErrorState(e.toString()));
      }
    });
    on<EditNoteEvent>((event, emit) async {
      emit(CreateNoteLoadedState());
      try {
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(event.noteId)
            .update(event.updatedNote.toJson());
      } catch (e) {
        emit(CreateNoteErrorState(e.toString()));
      }
    });
  }
}
