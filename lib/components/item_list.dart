import 'package:flutter/material.dart';
import 'package:panucci_delivery/cardapio.dart';

import '../models/item.dart';
import 'cartao.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.categoria});
  final String categoria;
  final List<Item> cardapio = todosOsItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (cardapio[index].categoria == categoria) {
              return Cartao(item: cardapio[index]);
            }
            return const SizedBox.shrink(); // Retorno padrão explícito
          },
          itemCount: cardapio.length,
        ),
      ),
    );
  }
}
