# color_image

A Flutter app that fetches an image from an API and adapts the UI using the extracted background color for a smooth and dynamic visual effect.<br>


https://github.com/user-attachments/assets/0543a933-792d-4897-94bf-73b4f3445086


## Features
🎨 Extracts background color from the image<br>
🖼 Displays API-loaded image<br>
⚡ Smooth transitions & dynamic UI<br>
🌗 Light/Dark theme toggle<br>
📶 Handles offline & error states<br>

## Getting Started
flutter pub get<br>
flutter run<br>

## Tech Stack
Flutter • Dart<br>
GetX state management<br>
image (pixel processing)<br>
cached_network_image<br>
connectivity_plus<br>

## Folder Structure
lib/<br>
 ├── controller/       # ImageController<br>
 ├── view/             # ImageScreen<br>
 ├── api/              # API helper<br>
 └── model/            # ImageResponseModel<br>
