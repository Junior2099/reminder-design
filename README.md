# Sistema de Gerenciamento de Lembretes

Sistema web desenvolvido em Java (JSP/Servlet) com padrão MVC para gerenciamento de lembretes pessoais, incluindo gráficos e análises estatísticas.

## Tecnologias Utilizadas

- **Java 11**
- **JSP (JavaServer Pages)**
- **Servlet API 4.0**
- **SQLite** (banco de dados)
- **Maven** (gerenciamento de dependências)
- **Chart.js** (gráficos)
- **Bootstrap** (interface)
- **JSTL** (JavaServer Pages Standard Tag Library)

## Funcionalidades

- ✅ Autenticação de usuários
- ✅ Criar, editar, listar e excluir lembretes
- ✅ Categorização de lembretes
- ✅ Sistema de prioridades (Alta, Média, Baixa)
- ✅ Status de lembretes (Pendente, Concluído, Cancelado)
- ✅ Dashboard com gráficos estatísticos:
  - Gráfico de pizza: Lembretes por Status
  - Gráfico de pizza: Lembretes por Prioridade
  - Gráfico de barras: Lembretes por Categoria
  - Gráfico de linha: Lembretes criados por mês (últimos 12 meses)
- ✅ Listagem de lembretes vencidos
- ✅ Interface responsiva e moderna

## Estrutura do Projeto

```
projetoAula/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── sistemalembretes/
│   │   │           ├── dao/           # Data Access Objects
│   │   │           ├── model/         # Modelos/Entidades
│   │   │           ├── servlet/       # Servlets (controladores)
│   │   │           └── util/         # Utilitários
│   │   └── webapp/
│   │       ├── assets/                # CSS, JS, imagens
│   │       ├── WEB-INF/
│   │       │   ├── views/             # Páginas JSP
│   │       │   └── web.xml            # Configuração web
│   │       └── index.jsp
│   └── database/                      # Banco SQLite
├── pom.xml                            # Configuração Maven
└── README.md
```

## Como Executar

### Pré-requisitos

- Java 11 ou superior
- Maven 3.6 ou superior
- Servidor de aplicação (Tomcat, Jetty, etc.)

### Passos

1. **Clone ou navegue até o diretório do projeto:**
   ```bash
   cd /home/zorin/Downloads/projetoAula
   ```

2. **Compile o projeto:**
   ```bash
   mvn clean compile
   ```

3. **Crie o pacote WAR:**
   ```bash
   mvn package
   ```

4. **Execute com o Tomcat Maven Plugin:**
   ```bash
   mvn tomcat7:run
   ```

   Ou com Jetty:
   ```bash
   mvn jetty:run
   ```

5. **Acesse no navegador:**
   - URL: `http://localhost:8080/sistema-lembretes`
   - Usuário padrão: `admin`
   - Senha padrão: `admin`

### Usando um Servidor de Aplicação Externo

1. **Gere o WAR:**
   ```bash
   mvn package
   ```

2. **Copie o arquivo `target/sistema-lembretes.war` para o diretório `webapps` do seu Tomcat/Jetty**

3. **Inicie o servidor e acesse:**
   ```
   http://localhost:8080/sistema-lembretes
   ```

## Banco de Dados

O sistema utiliza SQLite que é criado automaticamente na primeira execução. O banco de dados será criado em:
```
database/lembretes.db
```

### Estrutura das Tabelas

**usuarios:**
- id (INTEGER PRIMARY KEY)
- username (TEXT UNIQUE)
- password (TEXT)
- nome (TEXT)
- email (TEXT)
- role (TEXT)

**lembretes:**
- id (INTEGER PRIMARY KEY)
- titulo (TEXT)
- descricao (TEXT)
- data_hora (TEXT)
- prioridade (TEXT)
- categoria (TEXT)
- status (TEXT)
- data_criacao (TEXT)
- data_atualizacao (TEXT)
- usuario_id (INTEGER)

## Documentação da API

### Servlets

- **LoginServlet** (`/login`)
  - GET: Exibe página de login
  - POST: Autentica usuário

- **LogoutServlet** (`/logout`)
  - GET: Faz logout do usuário

- **LembreteServlet** (`/lembretes`)
  - GET: Lista lembretes, exibe formulário ou deleta
    - `?action=list` ou sem parâmetro: Lista lembretes
    - `?action=form`: Exibe formulário novo
    - `?action=edit&id=X`: Exibe formulário edição
    - `?action=delete&id=X`: Deleta lembrete
    - `?action=concluir&id=X`: Marca como concluído
  - POST: Salva lembrete (novo ou edição)
    - `action=save`

- **DashboardServlet** (`/dashboard`)
  - GET: Exibe dashboard com estatísticas e gráficos

## Desenvolvimento

### Compilar e Testar

```bash
# Compilar
mvn compile

# Executar testes (se houver)
mvn test

# Criar WAR
mvn package

# Limpar
mvn clean
```

## Contribuição

Este é um projeto educacional desenvolvido como exemplo de aplicação web Java usando padrão MVC.

## Licença

Este projeto é de código livre para fins educacionais.

---

**Desenvolvido em 2025**

