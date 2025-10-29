package com.sistemalembretes.model;

/**
 * Modelo para representar um usuário do sistema
 */
public class Usuario {
    private int id;
    private String username;
    private String password;
    private String nome;
    private String email;
    private String role;

    // Construtores
    public Usuario() {}

    public Usuario(String username, String password, String nome, String email, String role) {
        this.username = username;
        this.password = password;
        this.nome = nome;
        this.email = email;
        this.role = role;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", nome='" + nome + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}

