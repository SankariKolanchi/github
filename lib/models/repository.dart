class Repository {
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatarUrl;

  Repository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
  });
}
