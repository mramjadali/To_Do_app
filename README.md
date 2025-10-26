# to_do_app

A new Flutter project.

## Getting Started

# To-Do List Flutter Application

A feature-rich, cross-platform To-Do List application built with Flutter that helps you organize your tasks efficiently with a beautiful and intuitive user interface.

## 📱 App Preview

<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM.jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (1).jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (2).jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (3).jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (4).jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (5).jpeg" width="200" alt="Home Screen">
<img src="WhatsApp Image 2025-10-27 at 12.58.23 AM (6).jpeg" width="200" alt="Home Screen">

## ✨ Features

### 🎯 Core Functionality
- **Add Tasks**: Create new tasks with titles, descriptions, due dates, and categories
- **Edit Tasks**: Modify existing tasks with ease
- **Delete Tasks**: Remove tasks you no longer need
- **Mark as Complete**: Check off completed tasks with visual strikethrough
- **Local Storage**: All data persists locally using SharedPreferences

### 🎨 Advanced Features
- **Task Categories**: Organize tasks into categories (General, Work, Personal, Shopping, Health)
- **Due Dates**: Set and track task deadlines with visual indicators
- **Smart Filtering**: Filter tasks by status (All, Active, Completed)
- **Multiple Sorting**: Sort tasks by Created Date, Due Date, or Category
- **Overdue Detection**: Visual alerts for overdue tasks
- **Beautiful UI**: Material Design with smooth animations and intuitive interactions

### 📊 Task Management
- **Task Details**: Each task includes title, description, category, and due date
- **Visual Status**: Clear visual indicators for completed and overdue tasks
- **Category Colors**: Color-coded categories for quick visual recognition
- **Date Formatting**: Smart date display (Today, Tomorrow, or specific dates)

## 🚀 Installation

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Dart SDK
- Android Studio/VSCode with Flutter extension
- Android/iOS emulator or physical device

### Steps to Run

1. **Clone or Create Project**
   ```bash
   flutter create todo_app
   cd todo_app
   ```

2. **Add Dependencies**
   Update your `pubspec.yaml` file:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     shared_preferences: ^2.2.2
   ```

3. **Replace Files**
   Replace the default Flutter files with the provided code:
   - `lib/main.dart`
   - `lib/models/todo.dart`
   - `lib/services/todo_service.dart`
   - `lib/todo_list_screen.dart`
   - `lib/add_edit_todo_screen.dart`

4. **Install Dependencies**
   ```bash
   flutter pub get
   ```

5. **Run the Application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/
│   └── todo.dart            # Todo data model
├── services/
│   └── todo_service.dart    # Data persistence service
├── todo_list_screen.dart    # Main tasks list screen
└── add_edit_todo_screen.dart # Add/edit task screen
```

## 🛠 Technical Details

### Architecture
- **MVVM Pattern**: Clear separation of concerns
- **State Management**: Using Flutter's built-in `setState()`
- **Local Storage**: SharedPreferences for data persistence
- **Reactive UI**: Automatic UI updates on data changes

### Data Model
```dart
class Todo {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  DateTime? dueDate;
  String category;
}
```

### Key Technologies
- **Flutter Framework**: Cross-platform UI development
- **SharedPreferences**: Local data storage
- **Material Design**: Modern, responsive UI components
- **Dart Language**: Type-safe, object-oriented programming

## 🎨 UI/UX Features

### Main Screen
- **Floating Action Button**: Quick access to add new tasks
- **Filter & Sort**: Accessible via app bar action button
- **Task Cards**: Beautiful card-based task display
- **Interactive Elements**: Checkboxes, popup menus, and swipe gestures

### Task Cards Display
- **Completion Status**: Checkbox with strikethrough text
- **Category Badges**: Color-coded category chips
- **Due Date Indicators**: Visual cues for overdue tasks
- **Context Menu**: Edit and delete options

### Add/Edit Screen
- **Form Validation**: Required field validation
- **Category Selection**: Dropdown with predefined categories
- **Date Picker**: Interactive calendar for due dates
- **Rich Text Fields**: Title and description inputs

## 🔧 Customization

### Adding New Categories
Update the categories list in `add_edit_todo_screen.dart`:
```dart
final List<String> _categories = [
  'General',
  'Work', 
  'Personal',
  'Shopping',
  'Health',
  'Your New Category'  // Add here
];
```

### Modifying Category Colors
Update the color mapping in `todo_list_screen.dart`:
```dart
Color _getCategoryColor(String category) {
  final colors = {
    'General': Colors.blue.shade100,
    'Work': Colors.orange.shade100,
    // Add your custom colors
  };
  return colors[category] ?? Colors.grey.shade100;
}
```

## 📱 Platform Support

- **Android**: Fully supported (API 21+)
- **iOS**: Fully supported (iOS 11+)
- **Web**: Compatible
- **Desktop**: Compatible (Windows, macOS, Linux)

## 🔒 Data Persistence

- **Local Storage**: All data stored locally on device
- **No Internet Required**: Works completely offline
- **Data Integrity**: Automatic save/load operations
- **Backup Ready**: Easy to export/import data

## 🚀 Performance

- **Fast Loading**: Optimized data retrieval
- **Smooth Animations**: 60fps UI interactions
- **Efficient Rebuilds**: Minimal widget rebuilding
- **Memory Efficient**: Proper disposal of controllers

## 🐛 Troubleshooting

### Common Issues

1. **Tasks not appearing**
   - Check SharedPreferences permissions
   - Verify JSON serialization
   - Clear app data and restart

2. **Build errors**
   - Run `flutter clean`
   - Execute `flutter pub get`
   - Ensure Flutter SDK is up to date

3. **Date picker not working**
   - Check device locale settings
   - Verify DateTime formatting

### Debug Mode
Enable debug prints in `todo_service.dart` to monitor data operations:
```dart
print('Loading todos...');
print('Saving ${todos.length} todos');
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

## 📞 Support

If you have any questions or need help with setup, please open an issue in the repository.

---

**Built with ❤️ using Flutter**

This To-Do List application demonstrates modern Flutter development practices with a complete, production-ready feature set. Perfect for learning Flutter or as a starting point for your own task management applications!
