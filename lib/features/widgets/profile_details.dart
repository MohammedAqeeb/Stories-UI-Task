import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freck_stories/models/user.dart';

class ProfileDetails extends StatelessWidget {
  final User user;

  const ProfileDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          user.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          '2 Min',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(child: Container()),
        const Icon(Icons.more_horiz, color: Colors.white70),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(
            Icons.clear_sharp,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
