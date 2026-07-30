import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_language_provider.dart';

class KnowledgeHubScreen extends StatefulWidget {
  const KnowledgeHubScreen({Key? key}) : super(key: key);

  @override
  State<KnowledgeHubScreen> createState() => _KnowledgeHubScreenState();
}

class _KnowledgeHubScreenState extends State<KnowledgeHubScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _resources = [
    {
      'titleEn': 'Understanding Depression',
      'titleBn': 'বিষণ্ণতা বোঝা ও নিয়ন্ত্রণ',
      'descEn': 'Comprehensive guide to understanding depression, symptoms, and coping strategies.',
      'type': 'Article',
      'icon': Icons.article_outlined,
      'duration': '8 min',
      'isPremium': false,
    },
    {
      'titleEn': 'Parenting Tips for Special Children',
      'titleBn': 'বিশেষ শিশুদের প্যারেন্টিং টিপস',
      'descEn': 'Expert advice on raising children with special needs.',
      'type': 'Video',
      'icon': Icons.videocam_outlined,
      'duration': '25 min',
      'isPremium': false,
    },
    {
      'titleEn': 'Guided Audio Relaxation',
      'titleBn': 'মাইন্ডফুলনেস অডিও মেডিটেশন',
      'descEn': 'Deep breathing and stress relief audio session.',
      'type': 'Audio',
      'icon': Icons.headphones_outlined,
      'duration': '30 min',
      'isPremium': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isBn = Provider.of<AppLanguageProvider>(context).isBangla;
    final filters = ['All', 'Articles', 'Videos', 'Audio'];

    final filteredList = _selectedFilter == 'All'
        ? _resources
        : _resources.where((r) => r['type'].toString().toLowerCase() == _selectedFilter.toLowerCase().replaceAll('s', '')).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(isBn ? 'জ্ঞান কেন্দ্র' : 'Knowledge Hub', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Filter Row
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final f = filters[index];
                final isSelected = _selectedFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() => _selectedFilter = f);
                    },
                  ),
                );
              },
            ),
          ),

          // Resource Cards List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final r = filteredList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(r['icon'] as IconData, color: AppColors.primary, size: 24),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              isBn ? r['titleBn'] : r['titleEn'],
                              style: AppTypography.heading3(context),
                            ),
                          ),
                          if (r['isPremium'] as bool)
                            const Icon(Icons.lock_rounded, color: AppColors.warning, size: 20),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(r['descEn'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${r['type']} • ${r['duration']}', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: r['isPremium'] == true ? AppColors.warning : AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () {},
                            child: Text(
                              r['isPremium'] == true ? (isBn ? 'আনলক' : 'Unlock') : (isBn ? 'পড়ুন/দেখুন' : 'Read/Watch'),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
