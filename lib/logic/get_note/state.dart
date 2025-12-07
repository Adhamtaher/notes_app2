import 'package:equatable/equatable.dart';
import 'package:notes_app2/model/Notes.dart';

abstract class GetNoteStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNoteInitialState extends GetNoteStates{}
class GetNoteLoadingState extends GetNoteStates{}
class GetNoteLoadedState extends GetNoteStates{
  final List<Note> notes;

  GetNoteLoadedState(this.notes);

  @override
  // TODO: implement props
  List<Object?> get props => [notes];
}
class GetNoteErrorState extends GetNoteStates{
  final String error;

  GetNoteErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}