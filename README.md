# color_image

A Flutter app that fetches an image from an API and adapts the UI using the extracted background color for a smooth and dynamic visual effect.

Features
🎨 Extracts background color from the image
🖼 Displays API-loaded image
⚡ Smooth transitions & dynamic UI
🌗 Light/Dark theme toggle
📶 Handles offline & error states

Getting Started
flutter pub get
flutter run

Tech Stack
Flutter • Dart
GetX state management
image (pixel processing)
cached_network_image
connectivity_plus

Folder Structure
lib/
 ├── controller/       # ImageController
 ├── view/             # ImageScreen
 ├── api/              # API helper
 └── model/            # ImageResponseModel
