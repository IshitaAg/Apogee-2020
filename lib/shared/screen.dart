import 'package:flutter/material.dart';

class 
Screen extends StatelessWidget {

  const Screen({
    @required this.title,
    @required this.child,
    @required this.selectedTabIndex,
    Key key,
  }): super(key: key);

  final Widget child;
  final int selectedTabIndex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      //   centerTitle: true,
     //  ),
      body: Container(
        //for gradient, to be written later
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black54,
              Colors.black54,
            ],
            //fill anything later
          )
        ),
        child: SafeArea(
          child: child,
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: selectedTabIndex,
      ),
    );
  }

}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    this.currentIndex,
    Key key,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {

    if(currentIndex != -1) {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 9.0,
        unselectedFontSize: 9.0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        items: [
          _bottomNavItem(
            title: 'Stalls',
            selectedIconData: Icons.star,
            unselectedIconData: Icons.shop,
            isSelected: currentIndex == 0,
          ),
          _bottomNavItem(
            title: 'Orders',
            selectedIconData: Icons.star,
            unselectedIconData: Icons.list,
            isSelected: currentIndex == 1,
          ),
          _bottomNavItem(
            title: 'Events',
            selectedIconData: Icons.star,
            unselectedIconData: Icons.event,
            isSelected: currentIndex == 2,
          ),
          _bottomNavItem(
            title: 'Profile',
            selectedIconData: Icons.star,
            unselectedIconData: Icons.person,
            isSelected: currentIndex == 3,
          ),
          _bottomNavItem(
            title: 'More',
            selectedIconData: Icons.star,
            unselectedIconData: Icons.more,
            isSelected: currentIndex == 4,
          ),
        ],
        onTap: (i) {
          if(i == currentIndex) {
            return;
          }

          if(i == 0){
            Navigator.of(context).pushNamedAndRemoveUntil('/stalls', ModalRoute.withName('/'));
          }else if(i == 1){
            Navigator.of(context).pushNamedAndRemoveUntil('/orders', ModalRoute.withName('/'));
          }else if(i == 2){
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          }else if(i == 3){
            Navigator.of(context).pushNamedAndRemoveUntil('/profile', ModalRoute.withName('/'));
          }else if(i == 4){
            Navigator.of(context).pushNamedAndRemoveUntil('/more', ModalRoute.withName('/'));
          }
        },
      );
    }
    else{
      return Container(
        // color: Colors.greenAccent,
        height: 0,
      );
    }
  }
}

BottomNavigationBarItem _bottomNavItem({
  String title,
  IconData selectedIconData,
  IconData unselectedIconData,
  bool isSelected,
}) {
  return BottomNavigationBarItem(
    title: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(title),
    ),
    icon: Icon(isSelected ? selectedIconData : unselectedIconData),
  );
}