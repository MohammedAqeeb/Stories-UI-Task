import 'package:flutter/material.dart';

import 'package:freck_stories/models/user.dart';

class StoriesDescription extends StatelessWidget {
  final User user;
  final int currentStoryIndex;

  const StoriesDescription({
    super.key,
    required this.user,
    required this.currentStoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      right: 30,
      bottom: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.stories[currentStoryIndex].description,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 18,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Liked By',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      user.stories[currentStoryIndex].likedBy,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Icon(
            Icons.more_horiz,
            color: Colors.white70,
            size: 28,
          ),
        ],
      ),
    );
  }
}
