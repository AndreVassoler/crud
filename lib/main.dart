import 'package:flutter/material.dart';

void main() {
  runApp(BancoApp());
}

// StatelessWidget para a estrutura principal do aplicativo
class BancoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BancoHomePage(),
    );
  }
}

// StatefulWidget para a página inicial com o formulário
class BancoHomePage extends StatefulWidget {
  @override
  _BancoHomePageState createState() => _BancoHomePageState();
}

class _BancoHomePageState extends State<BancoHomePage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _saldoController = TextEditingController();

  // Lista de contas para armazenar os dados em memória
  List<Map<String, String>> contas = [];

  // Função para adicionar uma conta
  void _adicionarConta() {
    setState(() {
      contas.add({
        'nome': _nomeController.text,
        'saldo': _saldoController.text,
      });
      _nomeController.clear();
      _saldoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Conta Bancária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Titular'),
            ),
            TextField(
              controller: _saldoController,
              decoration: InputDecoration(labelText: 'Saldo Inicial'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConta,
              child: Text('Adicionar Conta'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de lista de contas usando MaterialPageRoute
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaContasPage(contas: contas),
                  ),
                );
              },
              child: Text('Ver Lista de Contas'),
            ),
          ],
        ),
      ),
    );
  }
}

// StatefulWidget para exibir a lista de contas bancárias
class ListaContasPage extends StatefulWidget {
  final List<Map<String, String>> contas;

  ListaContasPage({required this.contas});

  @override
  _ListaContasPageState createState() => _ListaContasPageState();
}

class _ListaContasPageState extends State<ListaContasPage> {
  // Função para remover uma conta da lista
  void _removerConta(int index) {
    setState(() {
      widget.contas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contas Bancárias'),
      ),
      body: ListView.builder(
        itemCount: widget.contas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.contas[index]['nome']!),
            subtitle: Text('Saldo: R\$ ${widget.contas[index]['saldo']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removerConta(index);
              },
            ),
          );
        },
      ),
    );
  }
}
