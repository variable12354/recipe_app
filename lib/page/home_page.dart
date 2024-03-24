import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/page/recipe_page.dart';
import 'package:recipe_app/services/data_service.dart';

import '../models/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Recipe Book")),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _buildUi() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _receipeTypeButton(),
          _recipeList(),
        ],
      ),
    );
  }

  Widget _receipeTypeButton() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    mealTypeFilter = "snack";
                  });
                },
                child: const Text("Snack")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    mealTypeFilter = "breakfast";
                  });
                },
                child: const Text("Breakfast")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    mealTypeFilter = "lunch";
                  });
                },
                child: const Text("Launch")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    mealTypeFilter = "dinner";
                  });
                },
                child: const Text("Dinner")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    mealTypeFilter = "Dessert";
                  });
                },
                child: const Text("Brunch")),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getRecipes(mealTypeFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("unable to load data"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Recipe recipe = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return RecipePage(recipe: recipe);
                                }));
                      },
                      contentPadding:
                          const EdgeInsets.only(top: 20, right: 5, left: 5),
                      leading: Image.network(recipe.image),
                      title: Text(recipe.name),
                      isThreeLine: true,
                      subtitle: Text(
                          "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}"),
                      trailing: Text(
                        "${recipe.rating.toString()} ⭐",
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  });
            }));
  }
}
