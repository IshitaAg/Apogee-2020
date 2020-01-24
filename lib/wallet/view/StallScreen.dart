import 'dart:convert';
import 'dart:io';
import 'package:apogee_main/shared/network/CustomHttpNetworkClient.dart';
import 'package:apogee_main/shared/screen.dart';

import 'package:apogee_main/wallet/data/database/WalletDao.dart';

import 'package:apogee_main/wallet/data/database/dataClasses/StallDataItem.dart';

import 'package:apogee_main/shared/constants/strings.dart' as prefix0;
import 'package:apogee_main/wallet/view/MenuScreen.dart';
import 'package:apogee_main/wallet/view/StallItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StallScreen extends StatefulWidget {
  @override
  _StallScreenState createState() => _StallScreenState();
}

class _StallScreenState extends State<StallScreen> {
  // MyStallModel _myStallModel;


  @override
  Widget build(BuildContext context) {
   // Provider.of<MyStallModel>(context, listen: false).fetchStallData();
    return Screen(
      selectedTabIndex: 0,
      title: "Stall",
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Consumer<MyStallModel>(
                builder: (context, mystallmodel, child) {
                  // _myStallModel = mystallmodel;
                  return mystallmodel.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : mystallmodel.stallItems.isEmpty
                          ? Center(child: Text("No Stalls are available"))
                          : Container(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      itemCount: mystallmodel.stallItems.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          child: StallItemWidget(
                                              stallDataItem: mystallmodel
                                                  .stallItems[index]),
                                          onTap: () {
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        index.toString())));
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuScreen(mystallmodel
                                                            .stallItems[index]
                                                            .stallId),
                                                    settings: RouteSettings(
                                                        name:
                                                            "/menuItems$index")));
                                            //TODO: open menu Screen
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//            Navigator.of(context).pushNamedAndRemoveUntil('/stalls', ModalRoute.withName('/events'));
class MyStallModel with ChangeNotifier {
  bool isLoading = false;

  //List<StallDataItem> stallItems;

  WalletDao _walletDao;
  CustomHttpNetworkClient _networkClient;
  List<StallDataItem> stallItems = [
    StallDataItem(
        stallId: 1, stallName: "Stall 1", closed: false, imageUrl: "ukbgukvsx"),
    StallDataItem(
        stallId: 2, stallName: "Stall 2", closed: false, imageUrl: "ukbgukvsx")
  ];

  MyStallModel({WalletDao walletDao, CustomHttpNetworkClient networkClient})
      : this._walletDao = walletDao,
        this._networkClient = networkClient {
    isLoading = true;
    displayStallDataItems();
    fetchStallData();
  }

  Future<Null> displayStallDataItems() async {
    stallItems = await _walletDao.getAllStalls();
    isLoading = false;
    notifyListeners();
    print("Updated CartItems = $stallItems");
  }

  Future<Null> fetchStallData() async {
    isLoading = true;
    notifyListeners();
    _networkClient.get(
      "wallet/vendors/",
      (response) async {
        await _walletDao.insertAllStalls((json.decode(response)));
        isLoading = false;
        displayStallDataItems();
        notifyListeners();
      },
    );
  }
}
