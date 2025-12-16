import 'dart:convert';
import 'dart:io';

import 'package:rick_morty_query_tester/constants/endpoint_info.dart';

/// A simple HTTP client for making GET requests with configurable parameters
class ApiClient {
  /// The base host URL (e.g., 'https://rickandmortyapi.com/api')

  /// List of path segments to append to the host
  final PathParameter query;

  /// Query parameters as key-value pairs
  final Map<String, dynamic> queryParameters;

  ApiClient({required this.query, this.queryParameters = const {}});

  /// Constructs the full URL with path and query parameters
  String get fullUrl {
    // Start with the host
    String url = EndpointInfo.apiHost;

    // Remove trailing slash from host if present
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    url += '/${query.pathSegment}';
      
    // Add query parameters if any exist
    if (queryParameters.isNotEmpty) {
      url += '?';
      List<String> queryPairs = [];
      queryParameters.forEach((key, value) {
        queryPairs.add(
          '${Uri.encodeComponent(key)}=${Uri.encodeComponent(value.toString())}',
        );
      });
      url += queryPairs.join('&');
    }

    return url;
  }

  /// Makes a GET request and returns the parsed JSON response as a Map
  Future<Map<String, dynamic>> get() async {
    final uri = Uri.parse(fullUrl);
    final client = HttpClient();

    try {
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return json.decode(responseBody) as Map<String, dynamic>;
      } else {
        throw HttpException(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } finally {
      client.close();
    }
  }

  /// Creates a copy of this ApiClient with some parameters optionally overridden
  ApiClient copyWith({
    PathParameter? query,
    Map<String, dynamic>? queryParameters,
  }) {
    return ApiClient(
      query: query ?? this.query,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }

  /// Adds a path parameter to the existing list
  ApiClient addPath(PathParameter query) {
    return copyWith(query: query);
  }

  /// Adds query parameters to the existing map
  ApiClient addQuery(Map<String, dynamic> newQueryParams) {
    return copyWith(queryParameters: {...queryParameters, ...newQueryParams});
  }

  /// Sets a single query parameter
  ApiClient setQuery(String key, dynamic value) {
    return addQuery({key: value});
  }

  @override
  String toString() {
    return 'ApiClient(fullUrl: $fullUrl)';
  }
}

/// Extension methods for easier URL building
extension ApiClientExtensions on ApiClient {
  /// Convenient method to add multiple path segments at once
  ApiClient path(PathParameter path) {
    return copyWith(query: path);
  }
}
