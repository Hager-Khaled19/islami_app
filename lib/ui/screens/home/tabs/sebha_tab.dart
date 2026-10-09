import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_assets.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int currentAzkarIndex = 0;
  double turns = 0.0;

  final List<String> azkar = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
  ];

  void onSebhaTap() {
    setState(() {
      counter++;
      turns += 1 / 33;

      if (counter == 33) {
        counter = 0;
        currentAzkarIndex = (currentAzkarIndex + 1) % azkar.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.sebhaBg),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Image.asset(
              AppAssets.islamiHeader,
              height: 120,
            ),
            const SizedBox(height: 12),
            const Text(
              'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onSebhaTap,
              child: SizedBox(
                width: mediaQuery.width,
                height: 380,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: Image.asset(
                        AppAssets.sebhaHead,
                        height: 90,
                      ),
                    ),
                    Positioned(
                      top: 65,
                      child: AnimatedRotation(
                        turns: turns,
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(
                          AppAssets.sebhaBody,
                          height: 300,
                          width: 300,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 175,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            azkar[currentAzkarIndex],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}