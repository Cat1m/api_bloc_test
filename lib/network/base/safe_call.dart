import 'package:api_bloc_test/network/base/api_result.dart';
import 'package:dio/dio.dart';

extension DioExtensions on Dio {
  Future<ApiResult<T>> safePost<T>(
    String path,
    T Function(Map<String, dynamic>) mapper, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await post(path,
          data: data,
          queryParameters: queryParameters,
          options: options?.copyWith(headers: headers),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return ApiResult.fromResponse(response, mapper);
    } on DioError catch (exception) {
      return ServerError<T>(exception.message);
    }
  }
}

//https://medium.com/@gokberk.yagci/building-a-generic-api-response-with-freezed-classes-and-working-demo-with-flutter-bloc-and-dio-ca4c6256fa44#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjZmOTc3N2E2ODU5MDc3OThlZjc5NDA2MmMwMGI2NWQ2NmMyNDBiMWIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTEwMTk5NzE4NTE3ODE1MDMyODUiLCJlbWFpbCI6ImNoaWVuMTIwNjk3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MDkzNDA0OTAsIm5hbWUiOiJDaGnhur9uIEzDqiBNaW5oIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tuRmZXT0RUZXZwa3gtbl9PbUtheGVQR1FWbGtfTmMwR0pVZVRqS0xONHBRPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkNoaeG6v24iLCJmYW1pbHlfbmFtZSI6IkzDqiBNaW5oIiwibG9jYWxlIjoidmkiLCJpYXQiOjE3MDkzNDA3OTAsImV4cCI6MTcwOTM0NDM5MCwianRpIjoiMmZhYTNkYmE4NTQ3ODkxZjIzYTdhNzNmMDdiYzYyNDFmMWUwMDQ2NSJ9.dFmO_E07j3-1AyU3qEwDWfWbjKh7Zs1H6dmCQoR4UudTowLLFi7ph9XOw9STjPszjxxT4f5naqRpy6kypm9eFm5Dd5H7tFrLsJOx9aSex8wz1afUSuW0lXX46x48wniMVtJpp90uTVLLD6L1ZTRrlDK7Z5Z64NcSak3eefyKklVyKsUoMbJJ9Jo4pXjWYA5TFvGloiV2UwZC3n4MyIgVJVGpx5sLlJ9oC1jUebSKq91oVAnUgoDTJ6FnyPo65VVe-Z9o4sw6ODhtE3VesbmupcoO4-pu_K7iAxuo7kyijwNVHENv2l4tjd2lohuaUbyt9drRVhdaNSrdq6xSZoTVFg
