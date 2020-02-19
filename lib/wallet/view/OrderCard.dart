import 'package:apogee_main/shared/constants/appColors.dart';
import 'package:apogee_main/shared/constants/app_theme_data.dart';
import 'package:apogee_main/shared/constants/strings.dart';
import 'package:apogee_main/wallet/data/database/dataClasses/OrderItems.dart';
import 'package:apogee_main/wallet/data/database/dataClasses/Orders.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  Orders orders;
  List<OrderItems> orderItems;

  OrderCard({
    @required this.orders,
    @required this.orderItems
  });

  @override
  Widget build(BuildContext context) {
    print("Order Items Recived = $orderItems");
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: orderCardBackground
      ), 
      padding: EdgeInsets.all(24.0),
      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Text(
                      orders.stallName, 
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
                /* Container(
                  margin: EdgeInsets.only(right: 4.0),
                  child: Text(
                    orderCardOrderNumber, 
                    style: Theme.of(context).textTheme.title,
                  )
                ), */
                Container(
                  child: Text(
                    "# ${orders.orderId}",
                    style: Theme.of(context).textTheme.title
                  )
                )
              ],
            ),
          ),
          Divider(color: offWhite44),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 4.0),
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              orderCardItems.toUpperCase(),
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              getOrderItemsInDisplayFormat(),
              style: Theme.of(context).textTheme.body2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          orderCardTotalAmount.toUpperCase(),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\u20B9 ${orders.totalPrice}",
                          style: Theme.of(context).textTheme.body1,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement OTP seen
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: getOTPButtonColor()
                    ),
                    child: Text(
                      orderCardOTP.toUpperCase(),
                      style: Theme.of(context).textTheme.body1.copyWith(color: orders.status == 2 ? Colors.black : Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: offWhite44),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    // TODO implement Repeat Order
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: Text(
                            orderCardRepeatOrder,
                            style: Theme.of(context).textTheme.body2.copyWith(color: orders.status == 3 ? Colors.white : Colors.grey),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.refresh,
                            color: orders.status == 4 ? Colors.white : Colors.grey,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 8.0),
                        child: Image(
                          image: AssetImage("assets/images/i1.png"),
                          width: 32,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(
                            "Delivered",
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Color getOTPButtonColor() {
    switch(orders.status) {
      case 0: return orderCardPending;
      case 1: return orderCardPending;
      case 2: return orderCardReady;
      case 3: return orderCardFinished;
    }
  }

  String getOrderItemsInDisplayFormat() {
    String items = "";
    for(OrderItems item in orderItems) {
      items += "${item.quantity} X ${item.itemName}, ";
    }
    // After the completion of the above loop, there would be an extra comma and a space after the last element
    // This operation is done to remove that
    items = items.substring(0, items.length - 2);
    return items;
  }
}