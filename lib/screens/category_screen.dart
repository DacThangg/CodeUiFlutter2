import 'package:budgetapp/helpers/color_helpers.dart';
import 'package:budgetapp/models/category_model.dart';
import 'package:budgetapp/models/expense_model.dart';
import 'package:budgetapp/widgets/radial_painter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category? category;

  CategoryScreen({this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpenses(){
    List<Widget> expenseList = [];
    widget.category?.expenses?.forEach((Expense expense) {
      expenseList.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 29.0,vertical: 10.0),
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2 ),
            blurRadius: 6.0,

          )]
        ),
        child: Padding(
          padding:  EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Text(expense.name ??'',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,

            ),
            ),
            Text('-\$${expense.cost?.toStringAsFixed(2)}',
style: TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  color: Colors.red,
),
            )
          ],),
        ),
      ));
    });
   return Column(children: expenseList);
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;

    // Check if category is not null before accessing its expenses
    if (widget.category != null) {
      widget.category!.expenses?.forEach((Expense expense) {
        totalAmountSpent += expense.cost ?? 0;
      });

      final double amountLeft = (widget.category!.maxAmount ?? 0) - totalAmountSpent;
      final double percent = amountLeft / (widget.category!.maxAmount ?? 1);

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category!.name ?? ''),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              iconSize: 30.0,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: CustomPaint(
                  foregroundPainter: RadialPainter(bgColor: Colors.grey[200],
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15.0,
                  ),
                  child: Center(child: Text('\$${amountLeft.toStringAsFixed(2)} /\$${widget.category!.maxAmount}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  ),),
                ),
              ),
              _buildExpenses(),

            ],
          ),
        ),
      );
    } else {
      // Handle the case where category is null
      return Scaffold(
        appBar: AppBar(
          title: Text('Category not found'),
        ),
        body: Center(
          child: Text('Category not found'),
        ),
      );
    }
  }
}
