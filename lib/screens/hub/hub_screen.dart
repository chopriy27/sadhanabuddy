import 'package:flutter/material.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Hub'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHubCard(
            context,
            'Acharyas',
            'Learn about great spiritual masters',
            Icons.person,
            Colors.purple,
            () {
              // TODO: Navigate to acharyas screen
            },
          ),
          const SizedBox(height: 12),
          _buildHubCard(
            context,
            'Bhajans & Kirtans',
            'Devotional songs categorized by mood',
            Icons.music_note,
            Colors.pink,
            () {
              // TODO: Navigate to bhajans screen
            },
          ),
          const SizedBox(height: 12),
          _buildHubCard(
            context,
            'Classes & Lectures',
            'Spiritual discourses and teachings',
            Icons.play_circle_outline,
            Colors.blue,
            () {
              // TODO: Navigate to classes screen
            },
          ),
          const SizedBox(height: 12),
          _buildHubCard(
            context,
            'Daily Verse',
            'Wisdom from sacred scriptures',
            Icons.auto_stories,
            Colors.orange,
            () {
              // TODO: Navigate to daily verse screen
            },
          ),
          const SizedBox(height: 12),
          _buildHubCard(
            context,
            'Festival Calendar',
            'Vaishnava festivals and celebrations',
            Icons.calendar_today,
            Colors.green,
            () {
              // TODO: Navigate to calendar screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHubCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}