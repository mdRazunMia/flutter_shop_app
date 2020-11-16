import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/badge.dart';
// import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
// import '../providers/products.dart';
import '../widgets/product_item.dart';
import '../providers/cart.dart';
import './cart_screen.dart';

enum FilterOptins {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _ShowOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptins selectedValue) {
              setState(() {
                if (FilterOptins.Favorites == selectedValue) {
                  // productsContainer.ShowFavoriteOnly(),
                  _ShowOnlyFavorites = true;
                } else {
                  // productsContainer.ShowAll(),
                  _ShowOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'), value: FilterOptins.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptins.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_ShowOnlyFavorites),
    );
  }
}
