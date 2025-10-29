package com.sistemalembretes.dao;

import com.sistemalembretes.model.Lembrete;
import com.sistemalembretes.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para operações com lembretes
 */
public class LembreteDAO {

    /**
     * Lista todos os lembretes de um usuário
     */
    public List<Lembrete> listarPorUsuario(int usuarioId) throws SQLException {
        List<Lembrete> lembretes = new ArrayList<>();
        String sql = "SELECT * FROM lembretes WHERE usuario_id = ? ORDER BY data_hora DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lembretes.add(mapearResultSet(rs));
                }
            }
        }
        return lembretes;
    }

    /**
     * Lista todos os lembretes
     */
    public List<Lembrete> listarTodos() throws SQLException {
        List<Lembrete> lembretes = new ArrayList<>();
        String sql = "SELECT * FROM lembretes ORDER BY data_hora DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lembretes.add(mapearResultSet(rs));
            }
        }
        return lembretes;
    }

    /**
     * Busca um lembrete pelo ID
     */
    public Lembrete buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM lembretes WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearResultSet(rs);
                }
            }
        }
        return null;
    }

    /**
     * Insere um novo lembrete
     */
    public boolean inserir(Lembrete lembrete) throws SQLException {
        String sql = "INSERT INTO lembretes (titulo, descricao, data_hora, prioridade, categoria, status, data_criacao, data_atualizacao, usuario_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, lembrete.getTitulo());
            stmt.setString(2, lembrete.getDescricao());
            stmt.setString(3, lembrete.getDataHora().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            stmt.setString(4, lembrete.getPrioridade());
            stmt.setString(5, lembrete.getCategoria());
            stmt.setString(6, lembrete.getStatus());
            stmt.setString(7, lembrete.getDataCriacao().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            stmt.setString(8, lembrete.getDataAtualizacao().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            stmt.setInt(9, lembrete.getUsuarioId());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (PreparedStatement idStmt = conn.prepareStatement("SELECT last_insert_rowid()")) {
                    try (ResultSet rs = idStmt.executeQuery()) {
                        if (rs.next()) {
                            lembrete.setId(rs.getInt(1));
                        }
                    }
                }
                return true;
            }
        }
        return false;
    }

    /**
     * Atualiza um lembrete existente
     */
    public boolean atualizar(Lembrete lembrete) throws SQLException {
        String sql = "UPDATE lembretes " +
                "SET titulo = ?, descricao = ?, data_hora = ?, prioridade = ?, categoria = ?, status = ?, data_atualizacao = ? " +
                "WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, lembrete.getTitulo());
            stmt.setString(2, lembrete.getDescricao());
            stmt.setString(3, lembrete.getDataHora().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            stmt.setString(4, lembrete.getPrioridade());
            stmt.setString(5, lembrete.getCategoria());
            stmt.setString(6, lembrete.getStatus());
            stmt.setString(7, LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            stmt.setInt(8, lembrete.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    /**
     * Remove um lembrete
     */
    public boolean remover(int id) throws SQLException {
        String sql = "DELETE FROM lembretes WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    /**
     * Conta lembretes por status
     */
    public int contarPorStatus(String status, int usuarioId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM lembretes WHERE status = ? AND usuario_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Conta lembretes por prioridade
     */
    public int contarPorPrioridade(String prioridade, int usuarioId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM lembretes WHERE prioridade = ? AND usuario_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, prioridade);
            stmt.setInt(2, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Conta lembretes por categoria
     */
    public List<Object[]> contarPorCategoria(int usuarioId) throws SQLException {
        List<Object[]> resultado = new ArrayList<>();
        String sql = "SELECT categoria, COUNT(*) as total FROM lembretes WHERE usuario_id = ? GROUP BY categoria";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String categoria = rs.getString("categoria");
                    int total = rs.getInt("total");
                    resultado.add(new Object[]{categoria != null ? categoria : "Sem categoria", total});
                }
            }
        }
        return resultado;
    }

    /**
     * Lista lembretes por status
     */
    public List<Lembrete> listarPorStatus(String status, int usuarioId) throws SQLException {
        List<Lembrete> lembretes = new ArrayList<>();
        String sql = "SELECT * FROM lembretes WHERE status = ? AND usuario_id = ? ORDER BY data_hora DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lembretes.add(mapearResultSet(rs));
                }
            }
        }
        return lembretes;
    }

    /**
     * Lista lembretes vencidos
     */
    public List<Lembrete> listarVencidos(int usuarioId) throws SQLException {
        List<Lembrete> lembretes = new ArrayList<>();
        String sql = "SELECT * FROM lembretes WHERE usuario_id = ? AND status = 'PENDENTE' AND data_hora < ? ORDER BY data_hora DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);
            stmt.setString(2, LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lembretes.add(mapearResultSet(rs));
                }
            }
        }
        return lembretes;
    }

    /**
     * Estatísticas mensais - lembretes criados por mês
     */
    public List<Object[]> estatisticasMensais(int usuarioId) throws SQLException {
        List<Object[]> resultado = new ArrayList<>();
        String sql = "SELECT strftime('%Y-%m', data_criacao) as mes, COUNT(*) as total " +
                "FROM lembretes WHERE usuario_id = ? " +
                "GROUP BY strftime('%Y-%m', data_criacao) " +
                "ORDER BY mes DESC LIMIT 12";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String mes = rs.getString("mes");
                    int total = rs.getInt("total");
                    resultado.add(new Object[]{mes, total});
                }
            }
        }
        return resultado;
    }

    /**
     * Mapeia um ResultSet para um objeto Lembrete
     */
    private Lembrete mapearResultSet(ResultSet rs) throws SQLException {
        Lembrete lembrete = new Lembrete();
        lembrete.setId(rs.getInt("id"));
        lembrete.setTitulo(rs.getString("titulo"));
        lembrete.setDescricao(rs.getString("descricao"));
        lembrete.setPrioridade(rs.getString("prioridade"));
        lembrete.setCategoria(rs.getString("categoria"));
        lembrete.setStatus(rs.getString("status"));
        lembrete.setUsuarioId(rs.getInt("usuario_id"));

        String dataHoraStr = rs.getString("data_hora");
        String dataCriacaoStr = rs.getString("data_criacao");
        String dataAtualizacaoStr = rs.getString("data_atualizacao");

        if (dataHoraStr != null) {
            lembrete.setDataHora(LocalDateTime.parse(dataHoraStr));
        }
        if (dataCriacaoStr != null) {
            lembrete.setDataCriacao(LocalDateTime.parse(dataCriacaoStr));
        }
        if (dataAtualizacaoStr != null) {
            lembrete.setDataAtualizacao(LocalDateTime.parse(dataAtualizacaoStr));
        }

        return lembrete;
    }
}

