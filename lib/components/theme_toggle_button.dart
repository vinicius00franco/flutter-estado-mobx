import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../store/theme_store.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

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
              children: [
                Icon(Icons.brightness_auto),
                SizedBox(width: 8),
                Text('Sistema'),
                if (themeStore.themeMode == ThemeMode.system)
                  Spacer(),
                if (themeStore.themeMode == ThemeMode.system)
                  Icon(Icons.check, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(Icons.light_mode),
                SizedBox(width: 8),
                Text('Claro'),
                if (themeStore.themeMode == ThemeMode.light)
                  Spacer(),
                if (themeStore.themeMode == ThemeMode.light)
                  Icon(Icons.check, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
          PopupMenuItem<ThemeMode>(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 8),
                Text('Escuro'),
                if (themeStore.themeMode == ThemeMode.dark)
                  Spacer(),
                if (themeStore.themeMode == ThemeMode.dark)
                  Icon(Icons.check, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
