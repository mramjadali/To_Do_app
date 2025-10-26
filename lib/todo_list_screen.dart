import 'package:flutter/material.dart';
import 'models/todo.dart';
import 'services/todo_service.dart';
import 'add_edit_todo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  String _filter = 'all'; // 'all', 'active', 'completed'
  String _sortBy = 'created'; // 'created', 'dueDate', 'category'

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoService.getTodos();
    setState(() {
      _todos = todos;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Todo> filtered = _todos;

    // Apply status filter
    if (_filter == 'active') {
      filtered = filtered.where((todo) => !todo.isCompleted).toList();
    } else if (_filter == 'completed') {
      filtered = filtered.where((todo) => todo.isCompleted).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      switch (_sortBy) {
        case 'dueDate':
          final aDate = a.dueDate ?? DateTime(2100);
          final bDate = b.dueDate ?? DateTime(2100);
          return aDate.compareTo(bDate);
        case 'category':
          return a.category.compareTo(b.category);
        case 'created':
        default:
          return b.createdAt.compareTo(a.createdAt);
      }
    });

    setState(() {
      _filteredTodos = filtered;
    });
  }

  void _addTodo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEditTodoScreen()),
    );

    if (result != null && result is Todo) {
      await _todoService.addTodo(result);
      _loadTodos();
      _showSnackBar('Task added successfully!');
    }
  }

  void _editTodo(Todo todo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTodoScreen(todo: todo)),
    );

    if (result != null && result is Todo) {
      await _todoService.updateTodo(result);
      _loadTodos();
      _showSnackBar('Task updated successfully!');
    }
  }

  void _deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    _loadTodos();
    _showSnackBar('Task deleted successfully!');
  }

  void _toggleTodo(String id) async {
    await _todoService.toggleTodo(id);
    _loadTodos();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter & Sort'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter by:'),
            DropdownButton<String>(
              value: _filter,
              onChanged: (value) {
                setState(() {
                  _filter = value!;
                });
                _applyFilters();
                Navigator.pop(context);
              },
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Tasks')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Sort by:'),
            DropdownButton<String>(
              value: _sortBy,
              onChanged: (value) {
                setState(() {
                  _sortBy = value!;
                });
                _applyFilters();
                Navigator.pop(context);
              },
              items: const [
                DropdownMenuItem(value: 'created', child: Text('Created Date')),
                DropdownMenuItem(value: 'dueDate', child: Text('Due Date')),
                DropdownMenuItem(value: 'category', child: Text('Category')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: 'Filter & Sort',
          ),
        ],
      ),
      body: _filteredTodos.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tasks found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'Add a new task to get started!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = _filteredTodos[index];
          return _buildTodoItem(todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoItem(Todo todo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) => _toggleTodo(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description.isNotEmpty)
              Text(
                todo.description,
                style: TextStyle(
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  color: todo.isCompleted ? Colors.grey : Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Chip(
                  label: Text(
                    todo.category,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: _getCategoryColor(todo.category),
                ),
                if (todo.dueDate != null) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(todo.dueDate!),
                    style: TextStyle(
                      fontSize: 12,
                      color: _isOverdue(todo.dueDate!) && !todo.isCompleted
                          ? Colors.red
                          : Colors.grey,
                      fontWeight: _isOverdue(todo.dueDate!) && !todo.isCompleted
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              _editTodo(todo);
            } else if (value == 'delete') {
              _deleteTodo(todo.id);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
        onTap: () => _editTodo(todo),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final colors = {
      'General': Colors.blue.shade100,
      'Work': Colors.orange.shade100,
      'Personal': Colors.green.shade100,
      'Shopping': Colors.purple.shade100,
      'Health': Colors.red.shade100,
    };
    return colors[category] ?? Colors.grey.shade100;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final taskDate = DateTime(date.year, date.month, date.day);

    if (taskDate == today) return 'Today';
    if (taskDate == tomorrow) return 'Tomorrow';
    return '${date.day}/${date.month}/${date.year}';
  }

  bool _isOverdue(DateTime dueDate) {
    return dueDate.isBefore(DateTime.now());
  }
}