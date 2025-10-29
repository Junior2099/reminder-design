package com.sistemalembretes.servlet;

import com.sistemalembretes.dao.LembreteDAO;
import com.sistemalembretes.model.Lembrete;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Servlet para gerenciamento de lembretes (CRUD)
 */
@WebServlet("/lembretes")
public class LembreteServlet extends HttpServlet {

    private LembreteDAO lembreteDAO;
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    public void init() throws ServletException {
        super.init();
        lembreteDAO = new LembreteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar se o usuário está logado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        int usuarioId = (Integer) session.getAttribute("usuarioId");
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                // Listar todos os lembretes do usuário
                List<Lembrete> lembretes = lembreteDAO.listarPorUsuario(usuarioId);
                request.setAttribute("lembretes", lembretes);
                request.getRequestDispatcher("/WEB-INF/views/lembretes.jsp").forward(request, response);
                
            } else if (action.equals("form")) {
                // Exibir formulário para novo lembrete
                request.getRequestDispatcher("/WEB-INF/views/lembrete-form.jsp").forward(request, response);
                
            } else if (action.equals("edit")) {
                // Exibir formulário para editar lembrete
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Lembrete lembrete = lembreteDAO.buscarPorId(id);
                    if (lembrete != null && lembrete.getUsuarioId() == usuarioId) {
                        request.setAttribute("lembrete", lembrete);
                        request.getRequestDispatcher("/WEB-INF/views/lembrete-form.jsp").forward(request, response);
                    } else {
                        request.setAttribute("erro", "Lembrete não encontrado ou sem permissão");
                        response.sendRedirect("lembretes");
                    }
                } else {
                    response.sendRedirect("lembretes");
                }
                
            } else if (action.equals("delete")) {
                // Excluir lembrete
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Lembrete lembrete = lembreteDAO.buscarPorId(id);
                    if (lembrete != null && lembrete.getUsuarioId() == usuarioId) {
                        boolean sucesso = lembreteDAO.remover(id);
                        if (sucesso) {
                            request.setAttribute("sucesso", "Lembrete removido com sucesso!");
                        } else {
                            request.setAttribute("erro", "Erro ao remover lembrete");
                        }
                    } else {
                        request.setAttribute("erro", "Lembrete não encontrado ou sem permissão");
                    }
                }
                response.sendRedirect("lembretes");
                
            } else if (action.equals("concluir")) {
                // Marcar lembrete como concluído
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Lembrete lembrete = lembreteDAO.buscarPorId(id);
                    if (lembrete != null && lembrete.getUsuarioId() == usuarioId) {
                        lembrete.setStatus("CONCLUIDO");
                        lembreteDAO.atualizar(lembrete);
                        request.setAttribute("sucesso", "Lembrete concluído!");
                    }
                }
                response.sendRedirect("lembretes");
            }
            
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("erro", "Erro ao processar solicitação: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar se o usuário está logado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        int usuarioId = (Integer) session.getAttribute("usuarioId");
        String action = request.getParameter("action");
        
        try {
            if (action.equals("save")) {
                // Salvar lembrete (novo ou edição)
                String idStr = request.getParameter("id");
                Lembrete lembrete = new Lembrete();
                
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Lembrete existente = lembreteDAO.buscarPorId(id);
                    if (existente != null && existente.getUsuarioId() == usuarioId) {
                        lembrete = existente;
                    } else {
                        request.setAttribute("erro", "Lembrete não encontrado ou sem permissão");
                        response.sendRedirect("lembretes");
                        return;
                    }
                }
                
                // Validar campos obrigatórios
                String titulo = request.getParameter("titulo");
                String dataHoraStr = request.getParameter("dataHora");
                
                if (titulo == null || titulo.trim().isEmpty()) {
                    request.setAttribute("erro", "Título é obrigatório");
                    request.setAttribute("lembrete", lembrete);
                    request.getRequestDispatcher("/WEB-INF/views/lembrete-form.jsp").forward(request, response);
                    return;
                }
                
                if (dataHoraStr == null || dataHoraStr.trim().isEmpty()) {
                    request.setAttribute("erro", "Data e hora são obrigatórias");
                    request.setAttribute("lembrete", lembrete);
                    request.getRequestDispatcher("/WEB-INF/views/lembrete-form.jsp").forward(request, response);
                    return;
                }
                
                lembrete.setTitulo(titulo.trim());
                lembrete.setDescricao(request.getParameter("descricao"));
                lembrete.setPrioridade(request.getParameter("prioridade"));
                lembrete.setCategoria(request.getParameter("categoria"));
                lembrete.setUsuarioId(usuarioId);
                
                try {
                    LocalDateTime dataHora = LocalDateTime.parse(dataHoraStr, formatter);
                    lembrete.setDataHora(dataHora);
                } catch (Exception e) {
                    request.setAttribute("erro", "Data/hora inválida");
                    request.setAttribute("lembrete", lembrete);
                    request.getRequestDispatcher("/WEB-INF/views/lembrete-form.jsp").forward(request, response);
                    return;
                }
                
                boolean sucesso;
                if (lembrete.getId() > 0) {
                    sucesso = lembreteDAO.atualizar(lembrete);
                    if (sucesso) {
                        request.setAttribute("sucesso", "Lembrete atualizado com sucesso!");
                    } else {
                        request.setAttribute("erro", "Erro ao atualizar lembrete");
                    }
                } else {
                    sucesso = lembreteDAO.inserir(lembrete);
                    if (sucesso) {
                        request.setAttribute("sucesso", "Lembrete cadastrado com sucesso!");
                    } else {
                        request.setAttribute("erro", "Erro ao cadastrar lembrete");
                    }
                }
                
                response.sendRedirect("lembretes");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro no banco de dados: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }
}

