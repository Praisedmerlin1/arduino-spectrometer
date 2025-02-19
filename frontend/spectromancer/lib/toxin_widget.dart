import 'package:flutter/material.dart';

class ToxinWidget extends StatelessWidget {
  final List<String?> toxins;
  const ToxinWidget({super.key, required this.toxins,});

  @override
  Widget build(BuildContext context) {
    return toxins.isEmpty ? Card(
      
      elevation: 1,
      color:Theme.of(context).colorScheme.tertiaryContainer,
      child: Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 12),
        child: Text("We didn't find any toxins in your sample", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
      ),),):
    Card(
      elevation: 1,
      color: Theme.of(context).colorScheme.errorContainer.withAlpha(150),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Toxins found in your sample:', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          ),
         ListView(shrinkWrap: true,
          children: toxins.map((toxin) => ListTile(title: Text(toxin!),)).toList(),
      
         )
        ],
      ),
    );
  }
}