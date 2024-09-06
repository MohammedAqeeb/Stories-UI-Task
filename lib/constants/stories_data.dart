import '../models/stories.dart';
import '../models/user.dart';

final List<User> userFinal = [
  const User(
    name: 'MOh',
    profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
    stories: [
      Story(
        url:
            'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
        media: MediaType.image,
        duration: Duration(seconds: 10),
        description: 'Nature At this Best #Moutains Calling',
        likedBy: 'the_bosssy',
        uploadTime: '3 Min',
      ),
      Story(
        url: 'https://wallpapercave.com/wp/wp4142237.jpg',
        media: MediaType.image,
        duration: Duration(seconds: 7),
        description: '#BigFatSale',
        likedBy: 'Dragonzzz',
        uploadTime: '1 Min',
      ),
    ],
  ),
  const User(
    name: 'Mac',
    profileImageUrl: 'https://wallpapercave.com/wp/wp10963736.jpg',
    stories: [
      Story(
        url:
            'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
        media: MediaType.image,
        duration: Duration(seconds: 5),
        description: 'The Grand View',
        likedBy: '12Ezay',
        uploadTime: '11 Min',
      ),
      Story(
        url:
            'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmxpaG0wMzJ4eGN1cjV1N2ZucjRvOGt0N2FhNWFjNWFueWVwOGJicSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/12HZukMBlutpoQ/giphy.webp',
        media: MediaType.image,
        duration: Duration(seconds: 8),
        description: 'THE GOAT',
        likedBy: 'Ali',
        uploadTime: '4 Min',
      ),
    ],
  ),
  const User(
    name: 'GymFreak',
    profileImageUrl: 'https://wallpapercave.com/wp/wp2957808.jpg',
    stories: [
      Story(
        url:
            'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYW9naGwzN2ZlZnc1aHBoZHJtb21hZ3piM3BrZ2w2NzNpdjNuMHk2aiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xTiTnqZMwp5twnUKfS/giphy.webp',
        media: MediaType.image,
        duration: Duration(seconds: 8),
        description: 'No Gain, No Pain',
        likedBy: 'Trainer',
        uploadTime: '10 Min',
      ),
    ],
  ),
  const User(
    name: 'Brad',
    profileImageUrl: 'https://wallpapercave.com/wp/vGGXgtr.jpg',
    stories: [
      Story(
        url: 'https://wallpapercave.com/wp/wp2194457.jpg',
        media: MediaType.image,
        duration: Duration(seconds: 8),
        description: 'Holidayss',
        likedBy: 'HR',
        uploadTime: '7 Min',
      ),
    ],
  ),
  const User(
    name: 'Death_Note',
    profileImageUrl: 'https://wallpapercave.com/wp/fNtXJLy.jpg',
    stories: [
      Story(
        url: 'https://wallpapercave.com/wp/71IW48O.jpg',
        media: MediaType.image,
        duration: Duration(seconds: 8),
        description: 'Space science and science',
        likedBy: 'MoonWalker',
        uploadTime: '1 Hour',
      ),
    ],
  ),
];
