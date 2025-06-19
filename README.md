# Flutter Drag & Drop Demo

A simple Flutter project demonstrating the `Draggable` and `DragTarget` widgets with bidirectional item movement.

## Features

- **Draggable Items**: Colorful fruit items that can be dragged between containers
- **Drop Zones**: Two containers that accept dropped items
- **Visual Feedback**: Items show elevation and transparency during drag operations
- **Bidirectional Movement**: Items can be moved back and forth between containers
- **Modern API**: Uses the latest `onAcceptWithDetails` and `onWillAcceptWithDetails` callbacks

## Getting Started

   ```bash
   git clone https://github.com/jacques-twizeyimana/flutter-draggable-target
   cd flutter-draggable-target
   flutter run
   ```

## How It Works

- **Drag**: Long press and drag items between the left and right containers
- **Drop**: Release items over a container to move them
- **Visual Cues**: Containers change color when items hover over them
- **Reset**: Use the bottom buttons to reset or reload items

## Key Components

- **`Draggable<T>`**: Makes widgets draggable with visual feedback
- **`DragTarget<T>`**: Creates drop zones that accept dragged items
- **`DragTargetDetails`**: Provides drag information including drop coordinates
- **State Management**: Uses `setState()` to update UI when items move

## Learning Objectives

- Understand Flutter's drag and drop system
- Learn proper state management for interactive widgets
- Implement visual feedback for better user experience
- Use modern Flutter APIs (non-deprecated callbacks)

## Requirements

- Flutter SDK 3.0+
- Dart 2.17+

![image](https://github.com/user-attachments/assets/595fe466-8705-4a31-9184-bee16ef7a644)
