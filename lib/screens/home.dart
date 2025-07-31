import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../components/item_list.dart';
import '../components/categoria_text.dart';
import '../components/search_input.dart';
import '../components/theme_toggle_button.dart';
import '../store/carrinho_store.dart';
import '../screens/checkout.dart';
import '../themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final carrinhoStore = Provider.of<CarrinhoStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: const Text('Panucci Delivery'),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.royalBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: SearchInput(searchTextController: searchTextController),
            ),
          ),
          const SliverToBoxAdapter(
            child: CategoriaText(titulo: "Mais comprados"),
          ),
          const SliverToBoxAdapter(
            child: ItemList(categoria: "mais comprados"),
          ),
          const SliverToBoxAdapter(
            child: CategoriaText(titulo: "Para o almoço"),
          ),
          const SliverToBoxAdapter(
            child: ItemList(categoria: "para o almoço"),
          ),
          const SliverToBoxAdapter(
            child: CategoriaText(titulo: "Para dividir"),
          ),
          const SliverToBoxAdapter(
            child: ItemList(categoria: "para dividir"),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Observer(
                builder: (_) => !carrinhoStore.listaVazia
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ver carrinho'),
                              Text('${carrinhoStore.totalItens} itens'),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
