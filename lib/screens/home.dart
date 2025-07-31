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
  HomeScreen({super.key}) : searchTextController = TextEditingController();

  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    final carrinhoStore = Provider.of<CarrinhoStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: const Text(
          'Panucci Delivery',
          style: TextStyle(color: Colors.white), // Cor branca fixa
        ),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      endDrawer: _buildCarrinhoDrawer(context, carrinhoStore),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1, // Começa abaixo do header
            right: 0,
            bottom: 0,
            child: Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onHorizontalDragStart: (_) {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.royalBlue, // Cor sólida para a barra lateral
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16), // Espaço acima da seta
                        const Icon(Icons.arrow_back_ios, color: Colors.white, size: 16), // Ícone fixo indicando arrastar
                        const SizedBox(height: 8),
                        const Icon(Icons.shopping_cart, color: Colors.white),
                        Observer(
                          builder: (_) => Text(
                            '${carrinhoStore.totalItens}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context), // Header sobrepõe a barra lateral
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.royalBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: SearchInput(
        searchTextController: searchTextController,
        textColor: Colors.white, // Cor branca fixa para o texto
        iconColor: Colors.white, // Cor branca fixa para os ícones
      ),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: <Widget>[
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
      ],
    );
  }

  Widget _buildCarrinhoDrawer(BuildContext context, CarrinhoStore carrinhoStore) {
    final double drawerWidth = MediaQuery.of(context).size.width * 0.75; // 75% da largura da tela

    return Drawer(
      width: drawerWidth,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        side: BorderSide( // Adiciona uma borda azul
          color: AppColors.royalBlue,
          width: 4.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Carrinho',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (carrinhoStore.listaVazia) {
                  return const Center(
                    child: Text('Seu carrinho está vazio'),
                  );
                }
                return ListView.builder(
                  itemCount: carrinhoStore.totalItens,
                  itemBuilder: (context, index) {
                    final item = carrinhoStore.listaItem[index];
                    return ListTile(
                      title: Text(item.nome),
                      subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}'),
                      trailing: Text('x${item.quantidade}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(homeContext: context),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Ir para o Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
