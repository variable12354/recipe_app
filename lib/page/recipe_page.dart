import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;

  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(centerTitle: true, title: const Text("Recipe Book")),
      body: SafeArea(child: _buildUi(context)),
    );
  }

  Widget _buildUi(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetails(context),
          _recipeIngridents(context),
          _recipeInstructions(context)
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(recipe.image))),
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("s${recipe.cuisine}, ${recipe.difficulty}",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
          Text(recipe.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(
              "Prep Time:${recipe.prepTimeMinutes} Minutes | Cook Time :  ${recipe.cookTimeMinutes} Minutes",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
          Text("${recipe.rating} ⭐ | ${recipe.reviewCount} ",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _recipeIngridents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20
      ),
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: recipe.ingredients.map((i) {
          return Row(
            children: [const Icon(Icons.check_box), Text(" $i")],
          );
        }).toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20
      ),
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: recipe.instructions.map((i) {
          return Text("${recipe.instructions.indexOf(i)}.  $i\n",maxLines: 3,textAlign: TextAlign.start,style: const TextStyle(fontSize: 15),);
        }).toList(),
      ),
    );
  }
}
