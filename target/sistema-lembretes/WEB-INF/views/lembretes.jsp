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

    <title>Sistema de Lembretes - Lista</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/assets/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="${pageContext.request.contextPath}/assets/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/assets/css/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style-extra-bs4.css" rel="stylesheet">
    
    <style>
        .badge-prioridade { padding: 5px 10px; }
        .prioridade-ALTA { background-color: #d9534f; color: white; }
        .prioridade-MEDIA { background-color: #f0ad4e; color: white; }
        .prioridade-BAIXA { background-color: #5cb85c; color: white; }
        .status-PENDENTE { background-color: #337ab7; color: white; }
        .status-CONCLUIDO { background-color: #5cb85c; color: white; }
        .status-CANCELADO { background-color: #999; color: white; }
        .vencido { background-color: #f0ad4e !important; color: white !important; }
    </style>
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
                                    <h3>Gerenciamento de Lembretes</h3>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <% if (request.getAttribute("sucesso") != null) { %>
                                <div class="alert alert-success alert-dismissible fade in" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                    ${sucesso}
                                </div>
                            <% } %>

                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Lista de Lembretes</h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card-box table-responsive">
                                                        <p class="text-muted font-13 m-b-30">
                                                            <a href="lembretes?action=form" class="btn btn-primary">
                                                                <i class="fa fa-plus"></i> Novo Lembrete
                                                            </a>
                                                        </p>
                                                        <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                                <tr>
                                                                    <th>ID</th>
                                                                    <th>Título</th>
                                                                    <th>Descrição</th>
                                                                    <th>Data/Hora</th>
                                                                    <th>Prioridade</th>
                                                                    <th>Categoria</th>
                                                                    <th>Status</th>
                                                                    <th>Ações</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="lembrete" items="${lembretes}">
                                                                    <tr class="${lembrete.vencido ? 'vencido' : ''}">
                                                                        <td>${lembrete.id}</td>
                                                                        <td>${lembrete.titulo}</td>
                                                                        <td>${lembrete.descricao != null ? lembrete.descricao : ''}</td>
                                                                        <td>
                                                                            <c:set var="dataHoraStr" value="${lembrete.dataHora.toString()}"/>
                                                                            <c:set var="dataHoraFormatted" value="${dataHoraStr.replace('T', ' ')}"/>
                                                                            ${dataHoraFormatted}
                                                                        </td>
                                                                        <td>
                                                                            <span class="badge badge-prioridade prioridade-${lembrete.prioridade}">
                                                                                ${lembrete.prioridade}
                                                                            </span>
                                                                        </td>
                                                                        <td>${lembrete.categoria != null ? lembrete.categoria : 'Sem categoria'}</td>
                                                                        <td>
                                                                            <span class="badge status-${lembrete.status}">
                                                                                ${lembrete.status}
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <c:if test="${lembrete.status == 'PENDENTE'}">
                                                                                <a href="lembretes?action=concluir&id=${lembrete.id}" 
                                                                                   class="btn btn-success btn-xs"
                                                                                   onclick="return confirm('Marcar este lembrete como concluído?')"
                                                                                   title="Concluir">
                                                                                    <i class="fa fa-check"></i>
                                                                                </a>
                                                                            </c:if>
                                                                            <a href="lembretes?action=edit&id=${lembrete.id}" class="btn btn-info btn-xs" title="Editar">
                                                                                <i class="fa fa-pencil"></i>
                                                                            </a>
                                                                            <a href="lembretes?action=delete&id=${lembrete.id}" 
                                                                               class="btn btn-danger btn-xs"
                                                                               onclick="return confirm('Tem certeza que deseja excluir este lembrete?')"
                                                                               title="Excluir">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
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
<!-- Datatables -->
<script src="${pageContext.request.contextPath}/assets/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

<!-- Custom Theme Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/custom.min.js"></script>

<!-- Datatables -->
<script>
    $(document).ready(function() {
        $('#datatable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Portuguese-Brasil.json"
            },
            "responsive": true,
            "order": [[ 0, "desc" ]]
        });
    });
</script>

</body>
</html>

