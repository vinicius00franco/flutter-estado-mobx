import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.searchTextController,
    this.textColor,
    this.iconColor,
  });

  final TextEditingController searchTextController;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: searchTextController,
        style: TextStyle(color: textColor), // Aplica a cor do texto
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          constraints: const BoxConstraints(maxHeight: 45),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: textColor ?? Colors.white), // Borda branca fixa
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: textColor ?? Colors.white), // Borda branca fixa para o estado habilitado
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: textColor ?? Colors.white, width: 2.0), // Borda branca fixa para o estado focado
          ),
          hintText: "Buscar um item",
          hintStyle: TextStyle(color: textColor?.withAlpha(180)), // Cor do hint text com opacidade ajustada
          prefixIcon: Icon(
            Icons.search,
            color: iconColor, // Aplica a cor do ícone
          ),
        ),
      ),
    );
  }
}
