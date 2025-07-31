import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../store/theme_store.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = Provider.of<ThemeStore>(context);

    return Observer(
      builder: (_) => PopupMenuButton<ThemeMode>(
        icon: Icon(
          themeStore.isCurrentlyDark
            ? Icons.dark_mode
            : Icons.light_mode,
        ),
        onSelected: (ThemeMode mode) {
          themeStore.setThemeMode(mode);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.system,
            child: Row(
              children: const [
                Icon(Icons.brightness_auto),
                SizedBox(width: 8),
                Text('Sistema'),
                Spacer(),
                Icon(Icons.check, color: Colors.blue),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.light,
            child: const Row(
              children: [
                Icon(Icons.light_mode),
                SizedBox(width: 8),
                Text('Claro'),
                Spacer(),
                Icon(Icons.check, color: Colors.blue),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.dark,
            child: const Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 8),
                Text('Escuro'),
                Spacer(),
                Icon(Icons.check, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
