import 'package:flutter/material.dart';

class FoodSafe extends StatelessWidget {
  final bool isSafe;
  final int numToxins;
  final bool data;
  const FoodSafe(
      {super.key,
      required this.isSafe,
      required this.numToxins,
      required this.data});

  @override
  Widget build(BuildContext context) {
    final TextStyle customTitle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontSize: 17, fontWeight: FontWeight.bold);

    Color textColour = Colors.grey;
    if (!data) {
      textColour = Colors.grey;
    } else if (isSafe) {
      textColour = Colors.green;
    } else if (numToxins > 0) {
      textColour = Colors.red;
    }

    Color boxColour = Colors.grey;
    if (!data) {
      boxColour = Theme.of(context).colorScheme.surface;
    } else if (isSafe) {
      boxColour = Theme.of(context).colorScheme.tertiaryContainer;
    } else if (numToxins > 0) {
      boxColour = Theme.of(context).colorScheme.errorContainer;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color: boxColour,
          elevation: 1,
          child: SizedBox(
            width: 200,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your food is',
                  style: customTitle,
                ),
                SizedBox(width: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      !data
                          ? Icons.help_outline
                          : (isSafe
                              ? Icons.check_circle_outline
                              : Icons.dangerous),
                      color: textColour,
                      size: 25
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      !data ? 'No Data' : (isSafe ? 'Safe' : 'Toxic'),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textColour,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: boxColour,
          elevation: 1,
          child: SizedBox(
            width: 250,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Toxicity level',
                  style: customTitle,
                ),
                SizedBox(
                      width: 2,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      !data
                          ? Icons.help_outline
                          : (isSafe
                              ? Icons.check_circle_outline
                              : (numToxins == 1
                                  ? Icons.warning_amber_outlined
                                  : (numToxins == 2
                                      ? Icons.error_outline
                                      : Icons.dangerous))),
                      color: textColour,
                      size: 25,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      !data
                          ? 'No Data'
                          : (isSafe
                              ? 'Zero'
                              : (numToxins == 1
                                  ? 'Mild'
                                  : (numToxins == 2 ? 'Moderate' : 'Extreme'))),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textColour,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
