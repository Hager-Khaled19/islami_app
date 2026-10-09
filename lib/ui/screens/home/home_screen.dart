import 'package:flutter/material.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import 'tabs/hadeth_tab.dart';
import 'tabs/quran_tab.dart';
import 'tabs/radio_tab.dart';
import 'tabs/sebha_tab.dart';
import 'tabs/time_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const QuranTab(),
    const HadethTab(),
    const SebhaTab(),
    const RadioTab(),
    const TimeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.blackColor,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.icQuran,
                width: 24, height: 24, color: AppColors.blackColor),
            activeIcon: Image.asset(AppAssets.icQuran,
                width: 24, height: 24, color: AppColors.whiteColor),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.icHadith,
                width: 24, height: 24, color: AppColors.blackColor),
            activeIcon: Image.asset(AppAssets.icHadith,
                width: 24, height: 24, color: AppColors.whiteColor),
            label: 'Hadith',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.icSebha,
                width: 24, height: 24, color: AppColors.blackColor),
            activeIcon: Image.asset(AppAssets.icSebha,
                width: 24, height: 24, color: AppColors.whiteColor),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.icRadio,
                width: 24, height: 24, color: AppColors.blackColor),
            activeIcon: Image.asset(AppAssets.icRadio,
                width: 24, height: 24, color: AppColors.whiteColor),
            label: 'Radio',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.icTime,
                width: 24, height: 24, color: AppColors.blackColor),
            activeIcon: Image.asset(AppAssets.icTime,
                width: 24, height: 24, color: AppColors.whiteColor),
            label: 'Time',
          ),
        ],
      ),
    );
  }
}