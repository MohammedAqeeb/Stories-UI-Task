import 'stories.dart';

class User {
  final String name;
  final String profileImageUrl;
  final List<Story> stories;

  const User({
    required this.name,
    required this.profileImageUrl,
    required this.stories,
  });
}
