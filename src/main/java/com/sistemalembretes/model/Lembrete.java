package com.sistemalembretes.model;

import java.time.LocalDateTime;

/**
 * Modelo para representar um lembrete
 */
public class Lembrete {
    private int id;
    private String titulo;
    private String descricao;
    private LocalDateTime dataHora;
    private String prioridade; // ALTA, MEDIA, BAIXA
    private String categoria;
    private String status; // PENDENTE, CONCLUIDO, CANCELADO
    private LocalDateTime dataCriacao;
    private LocalDateTime dataAtualizacao;
    private int usuarioId;

    // Construtores
    public Lembrete() {
        this.dataCriacao = LocalDateTime.now();
        this.dataAtualizacao = LocalDateTime.now();
        this.status = "PENDENTE";
        this.prioridade = "MEDIA";
    }

    public Lembrete(String titulo, String descricao, LocalDateTime dataHora, 
                    String prioridade, String categoria, int usuarioId) {
        this();
        this.titulo = titulo;
        this.descricao = descricao;
        this.dataHora = dataHora;
        this.prioridade = prioridade;
        this.categoria = categoria;
        this.usuarioId = usuarioId;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public String getPrioridade() {
        return prioridade;
    }

    public void setPrioridade(String prioridade) {
        this.prioridade = prioridade;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(LocalDateTime dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public LocalDateTime getDataAtualizacao() {
        return dataAtualizacao;
    }

    public void setDataAtualizacao(LocalDateTime dataAtualizacao) {
        this.dataAtualizacao = dataAtualizacao;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public boolean isVencido() {
        if (dataHora == null || status.equals("CONCLUIDO") || status.equals("CANCELADO")) {
            return false;
        }
        return LocalDateTime.now().isAfter(dataHora);
    }

    @Override
    public String toString() {
        return "Lembrete{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", descricao='" + descricao + '\'' +
                ", dataHora=" + dataHora +
                ", prioridade='" + prioridade + '\'' +
                ", categoria='" + categoria + '\'' +
                ", status='" + status + '\'' +
                ", dataCriacao=" + dataCriacao +
                ", dataAtualizacao=" + dataAtualizacao +
                ", usuarioId=" + usuarioId +
                '}';
    }
}

