

import 'dart:ffi';

import 'package:flutter/material.dart';

abstract class Veiculowidgets {
    key? key;
    final String nome;
    final Double preco;
    final String descricao;
    final String imageURL;
    final VoidCallback onTap;
    
  Veiculowidgets({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imageURL,
    required this.onTap

  }): super(key:key)

}

 String getVeiculoType();

 

 