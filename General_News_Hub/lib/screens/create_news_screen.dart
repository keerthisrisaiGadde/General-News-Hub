import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_article.dart';
import '../providers/news_provider.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key});

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _summary = TextEditingController();
  final _body = TextEditingController();
  final _author = TextEditingController();
  String _category = 'National';
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _summary.dispose();
    _body.dispose();
    _author.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _saving) return;
    setState(() => _saving = true);
    final article = NewsArticle(
      id: 'post_${DateTime.now().microsecondsSinceEpoch}',
      title: _title.text.trim(),
      category: _category,
      summary: _summary.text.trim(),
      body: _body.text.trim(),
      author: _author.text.trim(),
      publishedAt: DateTime.now().toLocal().toString().split(' ').first,
      isUserCreated: true,
    );
    try {
      await context.read<NewsProvider>().addArticle(article);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create news post')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Headline'), validator: _required),
            const SizedBox(height: 12),
            TextFormField(controller: _summary, decoration: const InputDecoration(labelText: 'Short summary'), validator: _required, maxLines: 2),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['National', 'World', 'Business', 'Politics', 'Entertainment']
                  .map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
              onChanged: (value) => setState(() => _category = value ?? 'National'),
            ),
            const SizedBox(height: 12),
            TextFormField(controller: _author, decoration: const InputDecoration(labelText: 'Author name'), validator: _required),
            const SizedBox(height: 12),
            TextFormField(controller: _body, decoration: const InputDecoration(labelText: 'Full article'), validator: _required, maxLines: 8),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.publish),
              label: Text(_saving ? 'Publishing...' : 'Publish post'),
            ),
          ],
        ),
      ),
    );
  }
}
