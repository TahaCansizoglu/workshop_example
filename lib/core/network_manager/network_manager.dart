import 'package:dio/dio.dart';
import 'package:workshop_example/product/api_endpoints/api_endpoints.dart';

class NetworkManager {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, data}) {
    try {
      return _dio.post(path, queryParameters: queryParameters, data: data);
    } on DioError catch (e) {
      return Future.value(e.response);
    }
  }
}
