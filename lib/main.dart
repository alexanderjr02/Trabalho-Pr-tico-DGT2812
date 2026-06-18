import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Mundo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ExploreMundoPage(),
    );
  }
}

class ExploreMundoPage extends StatelessWidget {
  const ExploreMundoPage({super.key});

  static const List<DestinationInfo> _destinations = [
    DestinationInfo(
      title: 'Gramado Premium',
      location: 'Gramado - RS',
      description:
          'Pacote com hospedagem, cafe da manha e passeio pelo centro da cidade.',
      rating: 4.8,
      icon: Icons.forest,
    ),
    DestinationInfo(
      title: 'Praias de Maceio',
      location: 'Maceio - AL',
      description:
          'Viagem ideal para quem busca mar azul, descanso e gastronomia local.',
      rating: 4.9,
      icon: Icons.beach_access,
    ),
    DestinationInfo(
      title: 'Aventura em Foz',
      location: 'Foz do Iguacu - PR',
      description:
          'Roteiro com cataratas, parque das aves e experiencias inesqueciveis.',
      rating: 4.7,
      icon: Icons.waterfall_chart,
    ),
  ];

  Column _buildButtonColumn(
    BuildContext context,
    IconData icon,
    String label,
    String message,
  ) {
    final Color color = Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          child: const Text('Acessar'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
    BuildContext context,
    DestinationInfo destination,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(destination.icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        destination.location,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(destination.rating.toStringAsFixed(1)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(destination.description),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reserva iniciada para ${destination.title}.'),
                  ),
                );
              },
              child: const Text('Reservar agora'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget titleSection = Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Explore Mundo Turismo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  'Experiencias para praia, serra e aventura em um so app.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.red),
          const SizedBox(width: 4),
          const Text('4.9'),
        ],
      ),
    );

    final Widget buttonSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(
            context,
            Icons.place,
            'DESTINOS',
            'Abrindo a secao de destinos.',
          ),
          _buildButtonColumn(
            context,
            Icons.luggage,
            'PACOTES',
            'Abrindo a secao de pacotes de viagem.',
          ),
          _buildButtonColumn(
            context,
            Icons.phone,
            'CONTATO',
            'Abrindo os canais de contato.',
          ),
        ],
      ),
    );

    final Widget searchSection = Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Pesquise um destino ou pacote',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Busca rapida iniciada.')),
              );
            },
            icon: const Icon(Icons.arrow_forward),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
        ),
        onSubmitted: (value) {
          final String term = value.trim().isEmpty ? 'todos os destinos' : value;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Buscando por $term.')),
          );
        },
      ),
    );

    final Widget textSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: const Text(
        'A Explore Mundo foi pensada para ajudar o cliente a descobrir '
        'destinos, comparar pacotes, consultar avaliacoes e finalizar reservas '
        'de forma simples. O aplicativo tambem destaca canais de contato, '
        'informacoes da agencia e sugestoes para viagens inesqueciveis.',
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Mundo'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Destinos'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Pacotes'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Contato'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Sobre nos'),
          ),
        ],
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Abrindo o destaque do destino principal.'),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  'images/explore_mundo.jpg',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destino em destaque',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ferias perfeitas para qualquer estacao',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          titleSection,
          buttonSection,
          searchSection,
          textSection,
          _buildSectionTitle('Pacotes em destaque'),
          for (final destination in _destinations)
            _buildDestinationCard(context, destination),
        ],
      ),
    );
  }
}

class DestinationInfo {
  final String title;
  final String location;
  final String description;
  final double rating;
  final IconData icon;

  const DestinationInfo({
    required this.title,
    required this.location,
    required this.description,
    required this.rating,
    required this.icon,
  });
}
