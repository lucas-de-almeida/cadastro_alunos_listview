import 'package:cadastro_alunos/entidades/usuario.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _emailController = TextEditingController();
  Usuario usuario = Usuario();
  var listaUsuario = <Usuario>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void salvarUsuario() {
    if (!_form.currentState.validate()) {
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: Duration(
              seconds: 2,
            ),
            content: Text(
              'Dados inválidos!',
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.red,
          ),
        );

      return;
    }
    _form.currentState.save();
    setState(() {
      listaUsuario.add(usuario);
      usuario = Usuario();
    });
    _nomeController.clear();
    _idadeController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        labelStyle: TextStyle(color: Colors.teal),
                        labelText: 'Nome completo',
                      ),
                      controller: _nomeController,
                      validator: (valor) {
                        if (valor.length < 3) return 'Nome muito curto';
                        if (valor.length > 30) return 'Nome muito longo';
                        return null;
                      },
                      onSaved: (nome) {
                        usuario.nome = nome;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        labelStyle: TextStyle(color: Colors.teal),
                        labelText: 'Idade',
                      ),
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      validator: (valor) {
                        if ((int.tryParse(valor) ?? 0) <= 0)
                          return 'Idade Inválida';
                        return null;
                      },
                      onSaved: (idade) {
                        usuario.idade = int.tryParse(idade);
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        labelStyle: TextStyle(color: Colors.teal),
                        labelText: 'Email',
                      ),
                      controller: _emailController,
                      validator: (email) {
                        if (!EmailValidator.validate(email))
                          return 'por favor digite um email valido';
                        return null;
                      },
                      onSaved: (email) {
                        usuario.email = email;
                      },
                    ),
                    SizedBox(height: 15),
                    OutlineButton(
                      onPressed: salvarUsuario,
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.teal,
                      borderSide: BorderSide(
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaUsuario.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://www.gravatar.com/avatar/$index?d=robohash',
                      ),
                    ),
                    title: Text(
                        '${listaUsuario[index].nome}, ${listaUsuario[index].idade} anos'),
                    subtitle: Text('${listaUsuario[index].email}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
