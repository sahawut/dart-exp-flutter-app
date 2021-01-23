# app

A new Flutter project.

## Web
### Run in Chrome
`flutter run -d chrome`
### Build Web
`flutter build web --release`
### Release build/web to https://sahawut.github.io/web-flutter
#### Change base href 
Change build/web/index.html `<base href="/">` to `<base href="/web-flutter/">`
#### Commit to github
`cp -rf build/web/* ../../web-flutter` 

## Android
### Build app-debug.apk
`flutter build apk --debug`

## iOS
### Build release iOS 
`flutter build ios`

## Integration testing
### iOS tests
`flutter drive --driver integration_test/driver.dart --target integration_test/app_test.dart`
### Chrome tests
* `/opt/chromedriver --port=4444`
* `flutter drive --driver integration_test/driver.dart --target integration_test/app_test.dart -d web-server`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
