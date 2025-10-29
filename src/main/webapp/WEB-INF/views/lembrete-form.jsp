<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/ico"/>

    <title>Sistema de Lembretes - ${lembrete != null ? 'Editar' : 'Novo'} Lembrete</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/assets/vendors/nprogress/nprogress.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/assets/css/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style-extra-bs4.css" rel="stylesheet">
</head>

<body class="nav-md">
<div class="body">
    <div class="main_container container-fluid">
        <div class="row">
            <div class="col-lg-2 col-md-2 left_col">
                <div class="left_col">
                    <div class="navbar nav_title" style="border: 0;">
                        <a href="dashboard" class="site_title"><i class="fa fa-bell"></i> <span>Lembretes</span></a>
                    </div>
                    <div class="clearfix"></div>

                    <!-- menu profile quick info -->
                    <div class="profile clearfix">
                        <div class="profile_pic">
                            <img src="${pageContext.request.contextPath}/assets/images/user.png" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>Bem-vindo,</span>
                            <h2>${sessionScope.nome}</h2>
                        </div>
                    </div>
                    <!-- /menu profile quick info -->

                    <br/>

                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                        <div class="menu_section">
                            <h3>Geral</h3>
                            <ul class="nav side-menu">
                                <li><a><i class="fa fa-home"></i> Início <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu">
                                        <li><a href="dashboard">Dashboard</a></li>
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-bell"></i> Lembretes <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu">
                                        <li><a href="lembretes">Listar Lembretes</a></li>
                                        <li><a href="lembretes?action=form">Novo Lembrete</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- /sidebar menu -->

                    <!-- /menu footer buttons -->
                    <div class="col-lg-2 sidebar-footer hidden-small">
                        <a data-toggle="tooltip" data-placement="top" title="Sair" href="logout">
                            <span class="fa fa-power-off" aria-hidden="true"></span>
                        </a>
                    </div>
                    <!-- /menu footer buttons -->
                </div>
            </div>
            <div class="col-lg-10 col-md-12 right_col_wrapper">
                <div class="row">
                    <!-- top navigation -->
                    <div class="top_nav col-md-12">
                        <div class="nav_menu">
                            <nav>
                                <div class="nav toggle">
                                    <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                                </div>

                                <ul class="nav navbar-nav navbar-right">
                                    <li class="">
                                        <a href="javascript:;" class="user-profile dropdown-toggle"
                                           data-toggle="dropdown" aria-expanded="false">
                                            <img src="${pageContext.request.contextPath}/assets/images/user.png" alt="">${sessionScope.nome}
                                            <span class=" fa fa-angle-down"></span>
                                        </a>
                                        <ul class="dropdown-menu dropdown-usermenu pull-right">
                                            <li><a href="logout"><i class="fa fa-sign-out pull-right"></i> Sair</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <!-- /top navigation -->
                    <!-- page content -->
                    <div class="right_col col-md-12" role="main">
                        <div class="">
                            <div class="page-title">
                                <div class="title_left">
                                    <h3>${lembrete != null ? 'Editar' : 'Novo'} Lembrete</h3>
                                </div>
                                <div class="title_right">
                                    <div class="col-md-5 col-sm-5 col-12 form-group pull-right top_search">
                                        <a href="lembretes" class="btn btn-secondary">
                                            <i class="fa fa-arrow-left"></i> Voltar
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Dados do Lembrete</h2>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">
                                            <br />
                                            
                                            <% if (request.getAttribute("erro") != null) { %>
                                                <div class="alert alert-danger">
                                                    <strong>Erro:</strong> ${erro}
                                                </div>
                                            <% } %>
                                            
                                            <form id="lembrete-form" class="form-horizontal form-label-left" 
                                                  action="lembretes" method="post">
                                                <input type="hidden" name="action" value="save">
                                                <c:if test="${lembrete != null}">
                                                    <input type="hidden" name="id" value="${lembrete.id}">
                                                </c:if>

                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="titulo">Título <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <input type="text" id="titulo" name="titulo" required="required" 
                                                               class="form-control col-md-7 col-xs-12" 
                                                               value="${lembrete != null ? lembrete.titulo : ''}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="descricao">Descrição
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <textarea id="descricao" name="descricao" class="form-control" rows="5">${lembrete != null ? lembrete.descricao : ''}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="dataHora">Data e Hora <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <input type="datetime-local" id="dataHora" name="dataHora" required="required" 
                                                               class="form-control col-md-7 col-xs-12"
                                                               <c:if test="${lembrete != null && lembrete.dataHora != null}">
                                                                   <%
                                                                       if (request.getAttribute("lembrete") != null) {
                                                                           com.sistemalembretes.model.Lembrete lembrete = (com.sistemalembretes.model.Lembrete) request.getAttribute("lembrete");
                                                                           if (lembrete.getDataHora() != null) {
                                                                               String dataHora = lembrete.getDataHora().toString();
                                                                               // Formato ISO: 2025-01-15T10:30:45 -> 2025-01-15T10:30
                                                                               if (dataHora.length() >= 16) {
                                                                                   dataHora = dataHora.substring(0, 16);
                                                                               }
                                                                               out.print("value=\"" + dataHora + "\"");
                                                                           }
                                                                       }
                                                                   %>
                                                               </c:if>
                                                               <c:if test="${lembrete == null}">
                                                                   value=""
                                                               </c:if>>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="prioridade">Prioridade <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <select id="prioridade" name="prioridade" required="required" class="form-control">
                                                            <option value="BAIXA" ${lembrete != null && lembrete.prioridade == 'BAIXA' ? 'selected' : ''}>Baixa</option>
                                                            <option value="MEDIA" ${lembrete != null && lembrete.prioridade == 'MEDIA' ? 'selected' : (lembrete == null ? 'selected' : '')}>Média</option>
                                                            <option value="ALTA" ${lembrete != null && lembrete.prioridade == 'ALTA' ? 'selected' : ''}>Alta</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="categoria">Categoria
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <input type="text" id="categoria" name="categoria" 
                                                               class="form-control col-md-7 col-xs-12"
                                                               placeholder="Ex: Trabalho, Pessoal, Compras..."
                                                               value="${lembrete != null ? lembrete.categoria : ''}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-12" for="status">Status
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-12">
                                                        <select id="status" name="status" class="form-control">
                                                            <option value="PENDENTE" ${lembrete != null && lembrete.status == 'PENDENTE' ? 'selected' : ''}>Pendente</option>
                                                            <option value="CONCLUIDO" ${lembrete != null && lembrete.status == 'CONCLUIDO' ? 'selected' : ''}>Concluído</option>
                                                            <option value="CANCELADO" ${lembrete != null && lembrete.status == 'CANCELADO' ? 'selected' : ''}>Cancelado</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="form-group">
                                                    <div class="col-md-6 col-sm-6 col-12 col-md-offset-3">
                                                        <button type="button" class="btn btn-primary" onclick="window.location.href='lembretes'">Cancelar</button>
                                                        <button type="submit" class="btn btn-success">Salvar</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /page content -->
                    <!-- footer content -->
                    <footer class="col-md-12">
                        <div class="pull-right">
                            Sistema de Gerenciamento de Lembretes - ©2025
                        </div>
                        <div class="clearfix"></div>
                    </footer>
                </div>
            </div>
            <!-- /footer content -->
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/assets/vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/assets/vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="${pageContext.request.contextPath}/assets/vendors/nprogress/nprogress.js"></script>

<!-- Custom Theme Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/custom.min.js"></script>

</body>
</html>

