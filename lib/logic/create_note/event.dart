import 'package:equatable/equatable.dart';
import 'package:notes_app2/model/Notes.dart';

abstract class CreateNoteEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SubmitNoteEvent extends CreateNoteEvent{
  final Note note;

  SubmitNoteEvent(this.note);

  @override
  // TODO: implement props
  List<Object?> get props => [note];
}
class EditNoteEvent extends CreateNoteEvent{
  final Note updatedNote;
  final String noteId;

  EditNoteEvent(this.updatedNote, this.noteId);
  @override
  // TODO: implement props
  List<Object?> get props => [updatedNote, noteId];
}