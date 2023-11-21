import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  BarChart(this.expenses);

  @override
  Widget build(BuildContext context) {

    double mostExpensive= 0;
    expenses.forEach((double price) {if(price >mostExpensive){
       mostExpensive = price;
    }
    });
    return Padding(
      padding:  EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,

            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,

              ),
              Text('Nov 10, 2019 - Nov 16, 2019',style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward),
                iconSize: 30.0,

              )
            ],
          ),
          SizedBox(
            height: 30.0,

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Bar(lable: 'Su',
                amountSpent: expenses[0],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'Mo',
                amountSpent: expenses[1],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'Tu',
                amountSpent: expenses[2],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'We',
                amountSpent: expenses[3],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'Th',
                amountSpent: expenses[4],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'Fr',
                amountSpent: expenses[5],
                mostExpensive: mostExpensive,
              ),
              Bar(lable: 'Sa',
                amountSpent: expenses[6],
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String? lable;
  final double amountSpent; // Change type to double
  final double mostExpensive; // Change type to double
  final double _maxBarHeight = 150.0;

  Bar({this.lable, required this.amountSpent, required this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: <Widget>[
        Text('\$${amountSpent.toStringAsFixed(2)}',style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
            
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(lable ?? 'Default Label',style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),),
      ],
    );
  }
}


