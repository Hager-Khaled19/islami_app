import 'package:flutter/material.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../sura_details/sura_details_screen.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  String searchQuery = '';

  final List<Map<String, String>> recentSuras = const [
    {
      'enName': 'Al-Anbiya',
      'arName': 'الأنبياء',
      'verses': '112 Verses',
    },
    {
      'enName': 'Al-Fatiha',
      'arName': 'الفاتحه',
      'verses': '7 Verses',
    },
  ];

  final List<Map<String, String>> surasList = const [
    {'id': '1', 'enName': 'Al-Fatiha', 'arName': 'الفاتحه', 'verses': '7 Verses'},
    {'id': '2', 'enName': 'Al-Baqarah', 'arName': 'البقرة', 'verses': '286 Verses'},
    {'id': '3', 'enName': 'Aal-E-Imran', 'arName': 'آل عمران', 'verses': '200 Verses'},
    {'id': '4', 'enName': 'An-Nisa', 'arName': 'النساء', 'verses': '176 Verses'},
    {'id': '5', 'enName': 'Al-Ma\'idah', 'arName': 'المائدة', 'verses': '120 Verses'},
    {'id': '6', 'enName': 'Al-An\'am', 'arName': 'الأنعام', 'verses': '165 Verses'},
    {'id': '7', 'enName': 'Al-A\'raf', 'arName': 'الأعراف', 'verses': '206 Verses'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSuras = surasList.where((sura) {
      final enName = sura['enName']!.toLowerCase();
      final arName = sura['arName']!;
      final query = searchQuery.toLowerCase().trim();
      return enName.contains(query) || arName.contains(query);
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  Image.asset(
                    AppAssets.islamiHeader,
                    height: 90,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: const TextStyle(color: AppColors.whiteColor),
                    decoration: InputDecoration(
                      hintText: 'Sura Name',
                      hintStyle: const TextStyle(color: AppColors.primaryColor),
                      prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.blackBgColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (searchQuery.isEmpty) ...[
                    const Text(
                      'Most Recently',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentSuras.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final sura = recentSuras[index];
                          return Container(
                            width: 285,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        sura['enName']!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        sura['arName']!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        sura['verses']!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  AppAssets.mostRecentlyBg,
                                  height: 110,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  const Text(
                    'Suras List',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final sura = filteredSuras[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SuraDetailsScreen.routeName,
                        arguments: sura,
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 52,
                                height: 52,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.suraNumberIc,
                                      width: 52,
                                      height: 52,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      sura['id']!,
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sura['enName']!,
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      sura['verses']!,
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                sura['arName']!,
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.whiteColor,
                          thickness: 0.5,
                        ),
                      ],
                    ),
                  );
                },
                childCount: filteredSuras.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}