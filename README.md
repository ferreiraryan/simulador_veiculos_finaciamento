# 🚗 Simulador de Financiamento de Veículos - Flutter

Um aplicativo móvel para simular o financiamento de veículos, construído com **Flutter** e **Dart**.

Desenvolvido como exercício prático dos conceitos de **Programação Orientada a Objetos** (herança e classes abstratas), **componentização de widgets**, **gerenciamento de estado** (`StatefulWidget`) e **arquitetura de pastas** (feature-first).

---

## 🚀 Tecnologias

Este projeto foi desenvolvido com as seguintes tecnologias:

- Flutter
- Dart

---

## 📂 Estrutura do Projeto

A estrutura de pastas segue o padrão *feature-first*, separando as responsabilidades para facilitar a manutenção e escalabilidade.

```
/simulador_veiculos_financiamento
│
├── assets
│   └── data
│       └── 📄 vehicles.json          # Mock dos dados dos veículos
│
├── lib
│   ├── app
│   │   ├── models
│   │   │   └── 📜 vehicle_model.dart    # Modelos de dados dos veículos
│   │   ├── navigation
│   │   │   └── 📜 app_router.dart       # Centraliza as rotas do app
│   │   └── services
│   │       ├── 📜 financing_service.dart  # Lógica de cálculo do financiamento
│   │       └── 📜 vehicle_mock_service.dart # Serviço que carrega os dados do JSON
│   │
│   ├── features
│   │   └── financing
│   │       ├── screens
│   │       │   ├── 📜 detail_screen.dart   # Tela de detalhes e calculadora
│   │       │   └── 📜 home_screen.dart     # Tela principal com a lista
│   │       └── widgets
│   │           └── 📜 vehicle_card.dart    # Widget customizado para o card do veículo
│   │
│   ├── shared
│   │   ├── constants
│   │   │   └── 📜 app_colors.dart      # Centraliza as cores do app
│   │   └── theme
│   │       └── 📜 app_theme.dart       # Define o tema visual do app
│   │
│   └── 📜 main.dart                    # Ponto de entrada da aplicação
│
├── 📦 pubspec.yaml
└── 📄 README.md                        # Este arquivo
```

---

## 📥 Instalação e Execução

```bash
# Clone este repositório
$ git clone https://github.com/ferreiraryan/simulador_veiculos_finaciamento

# Acesse o diretório do projeto
$ cd simulador_veiculos_finaciamento

# Instale as dependências
$ flutter pub get

# Execute o aplicativo
$ flutter run
```

---

## 🛠️ Uso

O aplicativo apresenta uma interface simples e intuitiva:

- **Tela Principal:** Exibe uma lista de veículos (carros, motos, etc.) carregados a partir de um arquivo JSON local.  
- **Tela de Detalhes:** Ao tocar em um veículo, o usuário é levado a uma nova tela que mostra todas as suas características (modelo, preço, descrição e detalhes específicos).  
- **Calculadora de Financiamento:** Na tela de detalhes, um formulário permite ao usuário inserir um valor de entrada e o prazo em meses para simular o valor das parcelas, com uma taxa de juros fixa.

---

## 🤝 Contribuindo

Sinta-se à vontade para contribuir! Basta seguir estes passos:

1. Faça um fork do projeto.
2. Crie uma branch com a sua funcionalidade:  
   ```bash
   git checkout -b minha-funcionalidade
   ```
3. Faça o commit das suas alterações:  
   ```bash
   git commit -m 'Adicionando nova funcionalidade'
   ```
4. Faça o push para a sua branch:  
   ```bash
   git push origin minha-funcionalidade
   ```
5. Abra um Pull Request.

---

## 📬 Contato

- **Ryan Ferreira** - ryanferreira4883@gmail.com  
- **GitHub:** [github.com/ferreiraryan](https://github.com/ferreiraryan)  
- **LinkedIn:** [linkedin.com/in/ferryan](https://www.linkedin.com/in/ferryan/)
