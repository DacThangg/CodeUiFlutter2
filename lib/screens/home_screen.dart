import 'package:budgetapp/data/data.dart';
import 'package:budgetapp/helpers/color_helpers.dart';
import 'package:budgetapp/models/category_model.dart';
import 'package:budgetapp/models/expense_model.dart';
import 'package:budgetapp/screens/category_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  _buildCategory(Category category, double totalAmountSpent){
    return GestureDetector(
       onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> CategoryScreen(category : category))),
      child: Container(margin: EdgeInsets.symmetric(horizontal: 20.0,
          vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          )]
        ),
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(category.name ?? '',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          
          ),
          Text(
            '\$${((category.maxAmount ?? 0) - totalAmountSpent).toStringAsFixed(2)} /\$${(category.maxAmount ?? 0).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600
            ),
          ),

        ],
      ),
      SizedBox(height: 10.0,),
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxBarWidth = constraints.maxWidth;

          final double maxAmount = category.maxAmount ?? 0.0;
          final double percent = maxAmount > 0 ? (maxAmount - totalAmountSpent) / maxAmount : 0.0;

          double barWidth = percent * maxBarWidth;
          if (barWidth.isNaN || barWidth.isInfinite || barWidth < 0) {
            barWidth = 0.0;
          }

          return   Stack(
            children: <Widget>[
              Container(

                height: 20.0,
                decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(15.1)),

              ),
              Container(
                height: 20.0,
                width: barWidth,
                decoration: BoxDecoration(color: getColor(context, percent),borderRadius: BorderRadius.circular(15.1)),
              )
            ],
          );
        },

      ),
  ],
),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            forceElevated: true,
            floating: true,
            //pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(icon: Icon(
                Icons.settings,

            ),
              iconSize: 30.0,
              onPressed: (){}

              ,),

            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget '),
            ),
            actions: <Widget>[
              IconButton(onPressed:( ){}, icon: Icon(Icons.add),iconSize: 30.0,)
            ],
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){

            if(
            index==0 ){



            return Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0 , 20.0, 10.0),

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,

                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: BarChart(weeklySpending),

            );
    } else{
              final Category category = categories[index-1];
              double totalAmountSpent = 0;
              category.expenses!.forEach((Expense expenses){
                totalAmountSpent += expenses.cost ??0;

              });
              return _buildCategory(category, totalAmountSpent);
            }
          }
          ,
            childCount: 1 + categories.length,
          ),
          )
        ],
      ),
    );
  }
}
