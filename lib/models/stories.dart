enum MediaType {
  image,
  video,
}

class Story {
  final String url, uploadTime, description, likedBy;
  final MediaType media;
  final Duration duration;

  const Story({
    required this.url,
    required this.media,
    required this.duration,
    required this.uploadTime,
    required this.description,
    required this.likedBy,
  });
}
