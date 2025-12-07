abstract class CreateNoteStates{}

class CreateNoteInitialState extends CreateNoteStates{}
class CreateNoteLoadingState extends CreateNoteStates{}
class CreateNoteLoadedState extends CreateNoteStates{}
class CreateNoteErrorState extends CreateNoteStates{
  final String error;

  CreateNoteErrorState(this.error);
}