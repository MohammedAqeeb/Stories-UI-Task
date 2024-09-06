import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/stories.dart';
import '../models/user.dart';
import 'widgets/profile_details.dart';
import 'widgets/status_bar_progress.dart';
import 'widgets/stories_description.dart';

class StoryScreen extends StatefulWidget {
  final List<User> users;

  const StoryScreen({super.key, required this.users});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController _userPageController; // Page controller for users
  late PageController _storyPageController; // Page controller for stories
  late AnimationController _animController; // Animation for Status bar
  late VideoPlayerController _videoController;
  late PageController pageController;

  final CarouselSliderController _carouselController =
      CarouselSliderController(); //  Carousel for Profile Slide

  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;

  @override
  void initState() {
    initialization();

    _userPageController.addListener(() {
      int currentPage = _userPageController.page?.round() ?? 0;
      if (currentPage != _currentUserIndex) {
        setState(() {
          _currentUserIndex = currentPage;

          _carouselController.animateToPage(currentPage);

          _currentStoryIndex = 0;
          _loadStory(
              story:
                  widget.users[_currentUserIndex].stories[_currentStoryIndex]);
        });
      }
    });

    _storyPageController.addListener(_onStoryPageChanged);

    super.initState();
  }

  void initialization() {
    pageController = PageController();
    _userPageController = PageController();
    _storyPageController = PageController();
    _animController = AnimationController(vsync: this);

    final Story firstStory = widget.users[_currentUserIndex].stories.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentStoryIndex + 1 <
              widget.users[_currentUserIndex].stories.length) {
            _currentStoryIndex += 1;
            _loadStory(
                story: widget
                    .users[_currentUserIndex].stories[_currentStoryIndex]);
          } else {
            _currentStoryIndex = 0;
            if (_currentUserIndex + 1 < widget.users.length) {
              _currentUserIndex += 1;
              _userPageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            } else {
              _currentUserIndex = 0;
              _userPageController.jumpToPage(0);
            }
            _loadStory(
                story: widget
                    .users[_currentUserIndex].stories[_currentStoryIndex]);
          }
        });
      }
    });
  }

  void _onStoryPageChanged() {
    int currentPage = _storyPageController.page?.round() ?? 0;
    if (_currentStoryIndex != currentPage) {
      setState(() {
        _currentStoryIndex = currentPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details),
      child: PageView.builder(
        controller: _userPageController,
        itemCount: widget.users.length,
        itemBuilder: (context, userIndex) {
          final User user = widget.users[userIndex];

          return _buildUserStories(user, userIndex);
        },
      ),
    );
  }

  Widget _buildUserStories(User user, int userIndex) {
    return Stack(
      children: [
        user.stories.isEmpty
            ? const Center(child: Text("No stories available"))
            : PageView.builder(
                controller: _storyPageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.stories.length,
                itemBuilder: (context, storyIndex) {
                  final Story story = user.stories[storyIndex];
                  switch (story.media) {
                    case MediaType.image:
                      return CachedNetworkImage(
                        imageUrl: story.url,
                        fit: BoxFit.cover,
                      );
                    case MediaType.video:
                      if (_videoController.value.isInitialized) {
                        return FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoController.value.size.width,
                            height: _videoController.value.size.height,
                            child: VideoPlayer(_videoController),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                  }
                },
              ),
        buildProfileAndStatusBar(user),
        Positioned(
          bottom: 100.0,
          left: 10.0,
          right: 10.0,
          child: buildCarouselSlider(user),
        ),
        StoriesDescription(
          user: user,
          currentStoryIndex: _currentStoryIndex,
        ),
      ],
    );
  }

  Widget buildProfileAndStatusBar(User user) {
    return Positioned(
      top: 40.0,
      left: 10.0,
      right: 10.0,
      child: Column(
        children: <Widget>[
          Row(
            children: user.stories
                .asMap()
                .map((i, e) {
                  return MapEntry(
                    i,
                    StatusBarProgress(
                      animController: _animController,
                      position: i,
                      currentIndex: _currentStoryIndex,
                    ),
                  );
                })
                .values
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 1.5,
              vertical: 10.0,
            ),
            child: ProfileDetails(user: user),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselSlider(User user) {
    final List<Widget> profileImageSlider = widget.users
        .map(
          (items) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  items.profileImageUrl,
                ),
              ),
            ),
          ),
        )
        .toList();

    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: profileImageSlider.length,
      itemBuilder: (context, index, realIndex) {
        return profileImageSlider[index];
      },
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 4,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: _currentUserIndex,
        viewportFraction: 0.25,
        onPageChanged: (index, reason) {
          setState(() {
            _currentUserIndex = index;
            _userPageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentStoryIndex - 1 >= 0) {
          _currentStoryIndex -= 1;
          _loadStory(
              story:
                  widget.users[_currentUserIndex].stories[_currentStoryIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentStoryIndex + 1 <
            widget.users[_currentUserIndex].stories.length) {
          _currentStoryIndex += 1;
          _loadStory(
              story:
                  widget.users[_currentUserIndex].stories[_currentStoryIndex]);
        } else if (_currentUserIndex + 1 < widget.users.length) {
          _currentUserIndex += 1;
          _userPageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
          _currentStoryIndex = 0;
          _loadStory(
              story:
                  widget.users[_currentUserIndex].stories[_currentStoryIndex]);
        }
      });
    } else {
      final Story story =
          widget.users[_currentUserIndex].stories[_currentStoryIndex];
      if (story.media == MediaType.video) {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
          _animController.stop();
        } else {
          _videoController.play();
          _animController.forward();
        }
      }
    }
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();

    switch (story.media) {
      case MediaType.image:
        _animController.duration = story.duration;
        _animController.forward();
        break;
      case MediaType.video:
        _videoController.dispose();
        _videoController =
            VideoPlayerController.networkUrl(Uri.parse(story.url))
              ..initialize().then((_) {
                setState(() {});
                if (_videoController.value.isInitialized) {
                  _animController.duration = _videoController.value.duration;
                  _videoController.play();
                  _animController.forward();
                }
              });
        break;
    }

    if (animateToPage) {
      _storyPageController.animateToPage(
        _currentStoryIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _storyPageController.removeListener(_onStoryPageChanged);
    _userPageController.dispose();
    _storyPageController.dispose();
    _animController.dispose();
    _videoController.dispose();
    super.dispose();
  }
}
