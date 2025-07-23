import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'store/carrinho_store.dart';
import 'store/item_store.dart';
import 'store/theme_store.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CarrinhoStore>(create: (_) => CarrinhoStore()),
        Provider<ItemStore>(create: (_) => ItemStore()),
        Provider<ThemeStore>(create: (_) => ThemeStore()),
      ],
      child: Consumer<ThemeStore>(
        builder: (context, themeStore, child) {
          return Observer(
            builder: (_) {
              // Detecta mudanças no tema do sistema
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final brightness = MediaQuery.platformBrightnessOf(context);
                themeStore.updateSystemBrightness(brightness);
              });

              return MaterialApp(
                title: 'Panucci Delivery',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: themeStore.themeMode,
                home: HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
