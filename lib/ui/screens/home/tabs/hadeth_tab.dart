import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/hadeth_model.dart';
import 'package:islami_app/ui/screens/hadeth_details/hadeth_details_screen.dart';
import 'package:islami_app/utils/app_assets.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<HadethModel> ahadethList = [];
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    loadHadethFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.hadethBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(
            AppAssets.islamiHeader,
            height: 120,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ahadethList.isEmpty
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE2BE7F),
              ),
            )
                : CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: ahadethList.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                    Navigator.pushNamed(
                      context,
                      HadethDetailsScreen.routeName,
                      arguments: ahadethList[index],
                    );
                  },
                  child: _buildHadethCard(ahadethList[index]),
                );
              },
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 0.68,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                enableInfiniteScroll: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHadethCard(HadethModel hadeth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE2BE7F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(
                  AppAssets.hadethBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                AppAssets.hadethBottomDec,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.hadethHeaderLeft,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hadeth.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      AppAssets.hadethHeaderRight,
                      height: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      hadeth.content,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.8,
                        color: Colors.black,
                      ),
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

  void loadHadethFile() async {
    try {
      String fileContent =
      await rootBundle.loadString('assets/hadeth/ahadeth.txt');
      List<String> hadethList = fileContent.split('#');

      List<HadethModel> tempList = [];

      for (var singleHadeth in hadethList) {
        String trimmed = singleHadeth.trim();
        if (trimmed.isEmpty) continue;

        List<String> lines = trimmed.split('\n');
        String title = lines[0].trim();
        lines.removeAt(0);
        String content = lines.join('\n').trim();

        tempList.add(HadethModel(title: title, content: content));
      }

      setState(() {
        ahadethList = tempList;
      });
    } catch (e) {
      debugPrint('Error loading hadeth file: $e');
    }
  }
}