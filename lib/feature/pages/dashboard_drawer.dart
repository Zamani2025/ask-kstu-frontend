import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/notice_board.dart';
import 'package:first_app/feature/pages/trending_news.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  var name;
  var index;
  var image;

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      image = localStorage.getString('image');
      index = localStorage.getInt('index');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: topColor,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        color: topColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      image != ''
                          ? CircleAvatar(
                              maxRadius: 24,
                              minRadius: 24,
                              backgroundColor: bottomColor,
                              backgroundImage: NetworkImage("${image}"),
                            )
                          : CircleAvatar(
                              maxRadius: 24,
                              minRadius: 24,
                              backgroundColor: bottomColor,
                              backgroundImage:
                                  AssetImage("assets/images/emptyprofile.png"),
                            ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${name}",
                            style: TextStyle(
                              color: bottomColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${index}",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: bottomColor,
                        size: 40,
                      )),
                ],
              ),
              const SizedBox(height: 55,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardIcons(
                      callback: () {
                        Navigator.of(context).pop();
                      },
                      icons: Icons.home,
                      title: "Dashboard",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.earbuds,
                      title: "Examination",
                    ),
                    DashboardIcons(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrendingNewsPage()));
                      },
                      icons: Icons.newspaper,
                      title: "Trending",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardIcons(
                      callback: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyCalenderPage()));
                                },
                      icons: Icons.calendar_month,
                      title: "Calendar",
                    ),
                    DashboardIcons(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeBoardPage()));
                      },
                      icons: Icons.border_all,
                      title: "Notice Board",
                    ),
                    DashboardIcons(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage()));
                      },
                      icons: Icons.person,
                      title: "My Profile",
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kpink, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "LogOut",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class DashboardIcons extends StatelessWidget {
  const DashboardIcons({
    Key? key,
    required this.title,
    required this.icons,
    required this.callback,
  }) : super(key: key);
  final String title;
  final IconData icons;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 30,
            maxRadius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              icons,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }
}
