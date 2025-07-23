import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  bool isDarkMode = false;

  @action
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
  }

  @action
  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  @action
  void setSystemTheme() {
    themeMode = ThemeMode.system;
  }

  @action
  void updateSystemBrightness(Brightness brightness) {
    isDarkMode = brightness == Brightness.dark;
  }

  @computed
  bool get isUsingSystemTheme => themeMode == ThemeMode.system;

  @computed
  bool get isCurrentlyDark {
    switch (themeMode) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return isDarkMode;
    }
  }
}
