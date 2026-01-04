import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sadhana_provider.dart';

class SadhanaTrackerScreen extends StatelessWidget {
  const SadhanaTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sadhana Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to sadhana history
            },
          ),
        ],
      ),
      body: Consumer<SadhanaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final entry = provider.todayEntry;
          if (entry == null) {
            return const Center(child: Text('No data available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateHeader(context),
                const SizedBox(height: 24),
                _buildJapaCounter(context, provider, entry.japaRounds),
                const SizedBox(height: 16),
                _buildReadingTracker(context, provider, entry.readingMinutes),
                const SizedBox(height: 16),
                _buildChecklistItem(
                  context,
                  'Mangala Arati',
                  entry.attendedMangalaArati,
                  () => provider.toggleMangalaArati(),
                ),
                const SizedBox(height: 16),
                _buildJournalSection(context, provider, entry.journalEntry),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(BuildContext context) {
    final now = DateTime.now();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(
              '${_getMonthName(now.month)} ${now.day}, ${now.year}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJapaCounter(BuildContext context, SadhanaProvider provider, int rounds) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Japa Rounds',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: rounds > 0
                      ? () => provider.updateJapaRounds(rounds - 1)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 40,
                ),
                const SizedBox(width: 24),
                Text(
                  '$rounds',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(width: 24),
                IconButton(
                  onPressed: () => provider.updateJapaRounds(rounds + 1),
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 40,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: rounds / 16,
              backgroundColor: Colors.grey[200],
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Goal: 16 rounds',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingTracker(BuildContext context, SadhanaProvider provider, int minutes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading (minutes)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: minutes > 0
                      ? () => provider.updateReadingMinutes(minutes - 5)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  '$minutes min',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => provider.updateReadingMinutes(minutes + 5),
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(
    BuildContext context,
    String title,
    bool isChecked,
    VoidCallback onToggle,
  ) {
    return Card(
      child: CheckboxListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        value: isChecked,
        onChanged: (_) => onToggle(),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildJournalSection(BuildContext context, SadhanaProvider provider, String entry) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gratitude Journal',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'What are you grateful for today?',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => provider.addJournalEntry(value),
              controller: TextEditingController(text: entry),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}