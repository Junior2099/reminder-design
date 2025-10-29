package com.sistemalembretes.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Classe utilitária para gerenciar conexões com o banco SQLite
 */
public class DatabaseConnection {
    private static final String DB_URL = "jdbc:sqlite:database/lembretes.db";
    private static Connection connection = null;

    /**
     * Obtém uma conexão com o banco de dados
     */
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("org.sqlite.JDBC");
                connection = DriverManager.getConnection(DB_URL);
                initializeDatabase();
            } catch (ClassNotFoundException e) {
                throw new SQLException("Driver SQLite não encontrado", e);
            }
        }
        return connection;
    }

    /**
     * Inicializa o banco de dados criando as tabelas necessárias
     */
    private static void initializeDatabase() throws SQLException {
        try (Statement stmt = connection.createStatement()) {
            // Criar tabela de usuários
            String createUsuariosTable = "CREATE TABLE IF NOT EXISTS usuarios (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "username TEXT UNIQUE NOT NULL," +
                    "password TEXT NOT NULL," +
                    "nome TEXT NOT NULL," +
                    "email TEXT," +
                    "role TEXT DEFAULT 'USER'" +
                    ")";
            stmt.execute(createUsuariosTable);

            // Criar tabela de lembretes
            String createLembretesTable = "CREATE TABLE IF NOT EXISTS lembretes (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "titulo TEXT NOT NULL," +
                    "descricao TEXT," +
                    "data_hora TEXT NOT NULL," +
                    "prioridade TEXT NOT NULL DEFAULT 'MEDIA'," +
                    "categoria TEXT," +
                    "status TEXT NOT NULL DEFAULT 'PENDENTE'," +
                    "data_criacao TEXT NOT NULL," +
                    "data_atualizacao TEXT NOT NULL," +
                    "usuario_id INTEGER NOT NULL," +
                    "FOREIGN KEY (usuario_id) REFERENCES usuarios(id)" +
                    ")";
            stmt.execute(createLembretesTable);

            // Inserir usuário admin padrão se não existir
            String checkAdmin = "SELECT COUNT(*) FROM usuarios WHERE username = 'admin'";
            try (var rs = stmt.executeQuery(checkAdmin)) {
                if (rs.getInt(1) == 0) {
                    String insertAdmin = "INSERT INTO usuarios (username, password, nome, email, role) " +
                            "VALUES ('admin', 'admin', 'Administrador', 'admin@sistemalembretes.com', 'ADMIN')";
                    stmt.execute(insertAdmin);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erro ao inicializar banco de dados: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Fecha a conexão com o banco de dados
     */
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println("Erro ao fechar conexão: " + e.getMessage());
        }
    }
}

