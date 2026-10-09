import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = 'sura-details';

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (verses.isEmpty && isLoading) {
      final sura = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      loadSuraFile(sura['id']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sura = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: AppColors.blackBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackBgColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        centerTitle: true,
        title: Text(
          sura['enName']!,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.suraDetailsBg,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppAssets.suraHeaderLeft,
                      height: 80,
                    ),
                    Text(
                      sura['arName']!,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      AppAssets.suraHeaderRight,
                      height: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                      : SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(
                        children: verses.asMap().entries.map((entry) {
                          int index = entry.key;
                          String verse = entry.value;
                          return TextSpan(
                            children: [
                              TextSpan(
                                text: '$verse ',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  height: 2.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '[${index + 1}] ',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadSuraFile(String suraId) async {
    try {
      String content = await rootBundle.loadString('assets/suras/$suraId.txt');
      List<String> lines = content.trim().split('\n');
      setState(() {
        verses = lines;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading sura file: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}