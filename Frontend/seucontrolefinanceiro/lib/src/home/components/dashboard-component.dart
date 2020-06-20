import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill-list/bill-list-page.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class DashboardComponent {
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);
  DateTime _date = DateTime.now().subtract(Duration(days: 30));
  Map months = Map<int, String>();

  Widget dashboard(BuildContext context, bills) {
    months.putIfAbsent(1, () => 'Janeiro');
    months.putIfAbsent(2, () => 'Fevereiro');
    months.putIfAbsent(3, () => 'Março');
    months.putIfAbsent(4, () => 'Abril');
    months.putIfAbsent(5, () => 'Maio');
    months.putIfAbsent(6, () => 'Junho');
    months.putIfAbsent(7, () => 'Julho');
    months.putIfAbsent(8, () => 'Agosto');
    months.putIfAbsent(9, () => 'Setembro');
    months.putIfAbsent(10, () => 'Outubro');
    months.putIfAbsent(11, () => 'Novembro');
    months.putIfAbsent(12, () => 'Dezembro');

    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 0),
      child: Container(
        height: 200,
        child: PageView(
          controller: PageController(viewportFraction: 1, initialPage: 0),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
          ],
        ),
      ),
    );
  }

  Widget _container(context, List<BillModel> bills) {
    _date = _date.add(Duration(days: 30));

    double valuePayment = 0;
    List<BillModel> newListBills = bills
        .where((element) =>
            DateTime.parse(element.payDAy).year == _date.year &&
            DateTime.parse(element.payDAy).month == _date.month &&
            element.paid == false)
        .toList();

    newListBills
        .where((element) => element.billType.compareTo('PAYMENT') == 0)
        .forEach((element) {
      valuePayment += double.parse(element.amount);
    });

    String dateString = '${months[_date.month]} de ${_date.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 30.0, left: 30.0),
      child: Material(
        elevation: 8.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 9.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      color: _primaryColor,
                    ),
                    Text(
                      '${months[_date.month]} de ${_date.year}',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.attach_money,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    'R\$ $valuePayment',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                        color: (valuePayment == 0)
                            ? Colors.green
                            : Colors.blueAccent),
                  ),
                ),
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                BillListPage(newListBills, dateString)));
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
