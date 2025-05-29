# Setup Instructions
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-news-app.git
   cd flutter-news-app
2. Navigate into the project directory.
3. Run `flutter pub get` to fetch dependencies.
4. Connect a device or emulator and run `flutter run`
    #Architecture

The app uses a simple and modular structure with separation of concerns.

- **State Management**: `Provider` package is used for managing state across the app such as login session and bookmarked articles.
- **Persistence**: `shared_preferences` is used to store login status and bookmarks locally.
- **API Layer**: `http` package is used for fetching news data from a public news API (e.g., NewsAPI.org).
- **Routing**: Flutter's built-in `Navigator` is used for screen navigation and `BottomNavigationBar` for tabs.🧩 Packages Used

| Package                | Purpose                                       |
|------------------------|-----------------------------------------------|
| `http`                 | Fetch news articles from the News API         |
| `provider`             | Manage app-wide state (bookmarks, login)      |
| `shared_preferences`   | Save login session and bookmarks persistently |
| `webview_flutter`      | Display full article in a WebView             |
| `intl`                 | Format published date in desired format       |
| 
