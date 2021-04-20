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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 11.5,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blueAccent,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Name : ${recentNames[itemIndex].name}',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   'Product Cost : ${recentNames[itemIndex].costPrice}',
              //   style: TextStyle(
              //     letterSpacing: 1.5,
              //     color: Colors.black87,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Text(
              //   'Product Selling Price : ${recentNames[itemIndex].sellingPrice}',
              //   style: TextStyle(
              //     letterSpacing: 1.5,
              //     color: Colors.black87,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
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
