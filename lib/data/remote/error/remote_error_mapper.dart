import 'dart:async';
import 'dart:io';

import 'package:anime_database/model/exception/http_exception.dart';
import 'package:dio/dio.dart';

class RemoteErrorMapper {
  RemoteErrorMapper();

  static Exception getException(dynamic error) {
    switch (error.runtimeType) {
      case DioException:
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            return TimeoutException(error.message);
          case DioExceptionType.sendTimeout:
            return TimeoutException(error.message);
          case DioExceptionType.receiveTimeout:
            return TimeoutException(error.message);
          case DioExceptionType.badResponse:
            return HTTPException(error.response?.statusCode ?? -1,
                error.response?.data.toString() ?? "");
          case DioExceptionType.unknown:
          case DioExceptionType.connectionError:
            if (error.error.toString().contains("SocketException")) {
              return SocketException(error.error.toString());
            }

            return Exception();
          default:
            return Exception();
        }
      case TypeError:
        return Exception('Type error');
      default:
        return error is Exception ? error : Exception();
    }
  }
}
