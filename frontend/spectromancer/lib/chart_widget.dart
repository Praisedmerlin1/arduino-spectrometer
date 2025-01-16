import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.dataPoints, required this.colors, required this.gradientColors});
  final List<FlSpot> dataPoints ;
  final List<Color> colors;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    
    return Center(
        child: dataPoints.isEmpty
            ? CircularProgressIndicator()
            : SizedBox(
              width: dataPoints.length * 15.0,
              child: LineChart(
                
                  LineChartData(
                    minX: dataPoints.first.x,
                    maxX: dataPoints.last.x,
                    maxY: dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.05,
                
                    lineTouchData: LineTouchData(enabled: true),
                    clipData: FlClipData.all(),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xff37434d)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: dataPoints,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                          stops: List.generate(dataPoints.length,
                              (index) => index / (dataPoints.length - 1)),
                        ),
                        barWidth: 1.5,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: gradientColors
                                .map((color) => color.withAlpha((0.3 * 255).toInt()))
                                .toList(),
                            stops: List.generate(dataPoints.length,
                                (index) => index / (dataPoints.length - 1)),
                          ),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false,),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true,
                        reservedSize: 40,
                        maxIncluded: false
                        //interval: 0.1,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true,reservedSize: 30),
                      ),
                    ),
                  ),
                ),
            ),
      );
  }
}
