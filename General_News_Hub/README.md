# General News Hub

A Flutter news reader starter app built with Provider and SharedPreferences.

## Features
- Browse a local starter feed of general news articles.
- Filter articles by All, National, World, Business, Politics, and Entertainment.
- Search headlines and article summaries.
- Open a full article detail page.
- Bookmark and unbookmark articles.
- Add locally authored news posts with form validation.
- Persist bookmarks and user-created posts on the device.
- Loading, error/retry, empty, and populated states.

## Screens
1. News Feed – searchable headlines and category filters.
2. Article Details – full summary, article body, category, and date.
3. Create News – validated form for a user-created post.
4. Bookmarks – saved articles.

## Data source and limitations
The app starts with clearly labelled sample articles in `lib/services/news_data_service.dart`. It does not currently connect to a live news provider, and the sample stories must not be presented as current breaking news. Users can create their own local posts; created posts and bookmarks are stored using SharedPreferences. No API key is required.

For a live-news extension, a team can integrate a permitted news API, document its source and terms, and keep API keys out of public GitHub source code.

## Run
1. Install Flutter stable (3.35 or later recommended), Android Studio, and Android SDK.
2. Extract this project folder.
3. Open the folder in Android Studio or VS Code.
4. Run `flutter pub get`.
5. Connect an Android phone with USB debugging enabled, or start an emulator.
6. Run `flutter run`.

## Test
Run `flutter test`.

## Team contribution ideas
- Member 1: News feed, search, and category filters.
- Member 2: Article details and create-news form.
- Member 3: Provider, local persistence, bookmarks, tests, and README.
Each member should make meaningful commits and understand their assigned feature.

## Important verification note
This is an initial source package. It has not been built or tested on a physical Android device in this environment. The team must run `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run`, then fix any issues before calling it submission-ready.
