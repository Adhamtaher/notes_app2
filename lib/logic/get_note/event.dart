import 'package:equatable/equatable.dart';

abstract class GetNoteEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DisplayNoteEvent extends GetNoteEvent{}

class DeleteNoteEvent extends GetNoteEvent{
  final String noteId;

  DeleteNoteEvent({required this.noteId});
}