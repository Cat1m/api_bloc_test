import 'package:dio/dio.dart';

abstract class ApiResult<T> {
  static const String _jsonNodeData = "Data";
  static const String _jsonNodeMessenge = "Messenge";
  static const String _jsonNodeStatus = "Status";

  static ApiResult<T> fromResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) mapper,
  ) {
    final responseData = response.data;
    final status = responseData[_jsonNodeStatus] as String;
    final message = responseData[_jsonNodeMessenge] as String;
    final data = responseData[_jsonNodeData] as Map<String, dynamic>;

    if (status == "OK") {
      return Success(mapper(data));
    } else {
      return ServerError(message);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data);
}

class ServerError<T> extends ApiResult<T> {
  final String message;

  ServerError(this.message);
}
