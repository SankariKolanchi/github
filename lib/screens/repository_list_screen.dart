import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/repositories_provider.dart';
import '../providers/error_provider.dart';

class RepositoryListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositories = ref.watch(repositoriesProvider);
    final error = ref.watch(errorProvider);

    if (error != null) {
      return Center(
        child: Text('An error occurred: $error'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
      ),
      body: ListView.builder(
        itemCount: repositories.length + 1,
        itemBuilder: (context, index) {
          if (index < repositories.length) {
            final repo = repositories[index];
            return ListTile(
              title: Text(repo.name),
              subtitle: Text(repo.description),
              trailing: Text('${repo.stars} stars'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(repo.ownerAvatarUrl),
              ),
            );
          } else if (repositories.isNotEmpty) {
            // Load more button
            ref.read(repositoriesProvider.notifier).fetchNextPage();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}