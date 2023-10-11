import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubApi {
  static const String baseUrl =
      'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc';

  Future<Map<String, dynamic>> fetchRepositories(int page) async {
    final Uri url = Uri.parse('$baseUrl&page=$page'); // Convert the string to Uri
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
