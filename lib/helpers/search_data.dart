import 'package:flutter/material.dart';
import 'package:smartpos/models/product.dart';

const List _productsName = [];

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.recentNames);

//  var names = _productsName.toList();

  //var recentNames = _productsName.toList();
  var dirt = [];
  List<Product> names = [];

  List<Product> recentNames = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = recentNames.where((element) {
      return element.name
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase());
    });
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.shopping_cart),
        title: Text(suggestionList.elementAt(index).name),
      ),
      itemCount: suggestionList.length,
    );
  }
}
