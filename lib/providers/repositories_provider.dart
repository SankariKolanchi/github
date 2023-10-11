import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/github_api.dart';
import '../models/repository.dart';

final repositoriesProvider =
StateNotifierProvider<RepositoriesNotifier, List<Repository>>(
      (_) => RepositoriesNotifier(),
);

class RepositoriesNotifier extends StateNotifier<List<Repository>> {
  RepositoriesNotifier() : super([]);

  final GithubApi _githubApi = GithubApi();

  int _currentPage = 1;

  Future<void> fetchNextPage() async {
    try {
      final data = await _githubApi.fetchRepositories(_currentPage);
      final newRepositories = (data['items'] as List<dynamic>)
          .map((item) => Repository(
        name: item['name'],
        description: item['description'] ?? 'No description',
        stars: item['stargazers_count'],
        ownerUsername: item['owner']['login'],
        ownerAvatarUrl: item['owner']['avatar_url'],
      ))
          .toList();
      state = [...state, ...newRepositories];
      _currentPage++;
    } catch (e) {
      // Handle error
    }
  }
}
