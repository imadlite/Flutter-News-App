class Success {
  int code;
  Object response;
  Success({required this.code, required this.response});
  int get _code => code;
  Object get _response => response;
}

class Failure {
  int code;
  Object errorResponse;
  Failure({required this.code, required this.errorResponse});
  int get _code => code;
  Object get _response => errorResponse;
}
