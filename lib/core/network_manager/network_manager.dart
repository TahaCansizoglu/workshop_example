import 'package:dio/dio.dart';
import 'package:workshop_example/product/api_endpoints/api_endpoints.dart';

abstract class NetworkManager {
  // Neden abstract kullandık? -berke
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, dynamic data});
  void setToken(String token);
}

class NetworkManagerImpl implements NetworkManager {
  //neden singleton ,ne bu singleton? -taha
  static final NetworkManagerImpl instance = NetworkManagerImpl._internal();

  NetworkManagerImpl._internal() {
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
  }

  late Dio _dio;

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, data}) {
    return _dio.post(path, queryParameters: queryParameters, data: data);
  }

  @override
  void setToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }
}
