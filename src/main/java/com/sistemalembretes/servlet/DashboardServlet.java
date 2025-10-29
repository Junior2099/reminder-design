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
import java.util.List;

/**
 * Servlet para dashboard com estatísticas
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private LembreteDAO lembreteDAO;

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
        
        try {
            // Buscar todos os lembretes do usuário
            List<Lembrete> todosLembretes = lembreteDAO.listarPorUsuario(usuarioId);
            
            // Estatísticas
            int totalLembretes = todosLembretes.size();
            int pendentes = lembreteDAO.contarPorStatus("PENDENTE", usuarioId);
            int concluidos = lembreteDAO.contarPorStatus("CONCLUIDO", usuarioId);
            int cancelados = lembreteDAO.contarPorStatus("CANCELADO", usuarioId);
            
            int altaPrioridade = lembreteDAO.contarPorPrioridade("ALTA", usuarioId);
            int mediaPrioridade = lembreteDAO.contarPorPrioridade("MEDIA", usuarioId);
            int baixaPrioridade = lembreteDAO.contarPorPrioridade("BAIXA", usuarioId);
            
            // Lembretes vencidos
            List<Lembrete> vencidos = lembreteDAO.listarVencidos(usuarioId);
            int totalVencidos = vencidos.size();
            
            // Lembretes por categoria
            List<Object[]> porCategoria = lembreteDAO.contarPorCategoria(usuarioId);
            
            // Estatísticas mensais
            List<Object[]> estatisticasMensais = lembreteDAO.estatisticasMensais(usuarioId);
            
            // Últimos lembretes
            List<Lembrete> ultimosLembretes = todosLembretes.size() > 5 
                    ? todosLembretes.subList(0, Math.min(5, todosLembretes.size()))
                    : todosLembretes;
            
            // Atribuir ao request
            request.setAttribute("totalLembretes", totalLembretes);
            request.setAttribute("pendentes", pendentes);
            request.setAttribute("concluidos", concluidos);
            request.setAttribute("cancelados", cancelados);
            request.setAttribute("altaPrioridade", altaPrioridade);
            request.setAttribute("mediaPrioridade", mediaPrioridade);
            request.setAttribute("baixaPrioridade", baixaPrioridade);
            request.setAttribute("totalVencidos", totalVencidos);
            request.setAttribute("vencidos", vencidos);
            request.setAttribute("porCategoria", porCategoria);
            request.setAttribute("estatisticasMensais", estatisticasMensais);
            request.setAttribute("ultimosLembretes", ultimosLembretes);
            
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }
}

