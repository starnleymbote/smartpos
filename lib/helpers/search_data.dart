import 'package:flutter/material.dart';
import 'package:smartpos/models/product.dart';
import 'package:smartpos/screens/categories_screen.dart';

var itemIndex;
CategoryScreen categoryscreen = CategoryScreen();

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.recentNames);

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

    return Card(
      elevation: 7.5,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(
            top: 4.0,
            left: 8.0,
            right: 4.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name : ${recentNames[itemIndex].name}',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Product Cost : ${recentNames[itemIndex].costPrice}',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Product Selling Price : ${recentNames[itemIndex].sellingPrice}',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return ListTile(
      title: Text(recentNames[itemIndex].name.toString()),
    );
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
          print("printing the index number");
          itemIndex = index;
          print(itemIndex);
        },
        leading: Icon(Icons.shopping_cart),
        title: Text(suggestionList.elementAt(index).name),
      ),
      itemCount: suggestionList.length,
    );
  }
}
