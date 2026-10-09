import 'package:flutter/material.dart';
import '../../../hadeth_model.dart';
import '../../../utils/app_assets.dart';

class HadethDetailsScreen extends StatelessWidget {
  static const String routeName = 'hadeth_details';

  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HadethModel hadeth =
    ModalRoute.of(context)!.settings.arguments as HadethModel;

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFFE2BE7F)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Hadith 1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFE2BE7F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF202020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            hadeth.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFE2BE7F),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                hadeth.content,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFFE2BE7F),
                                  fontSize: 18,
                                  height: 1.8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        AppAssets.suraHeaderLeft,
                        width: 80,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        AppAssets.suraHeaderRight,
                        width: 80,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        AppAssets.hadethBottomDec,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}