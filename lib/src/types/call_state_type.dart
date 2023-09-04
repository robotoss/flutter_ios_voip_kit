enum CallStateType {
  idle('idle'),
  calling('calling');

  const CallStateType(this.value);

  final String value;
}

extension CallStateTypeEx on CallStateType {
  static CallStateType? create(int value) {
    switch (value) {
      case 0:
        return CallStateType.idle;
      case 1:
        return CallStateType.calling;
      default:
        return null;
    }
  }
}
