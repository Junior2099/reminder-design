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

    <title>Sistema de Lembretes - Dashboard</title>

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
                        <!-- top tiles -->
                        <div class="row tile_count">
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-4 col-6 tile_stats_count">
                                <span class="count_top"><i class="fa fa-bell"></i> Total de Lembretes</span>
                                <div class="count">${totalLembretes}</div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-4 col-6 tile_stats_count">
                                <span class="count_top"><i class="fa fa-clock-o"></i> Pendentes</span>
                                <div class="count blue">${pendentes}</div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-4 col-6 tile_stats_count">
                                <span class="count_top"><i class="fa fa-check"></i> Concluídos</span>
                                <div class="count green">${concluidos}</div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-4 col-6 tile_stats_count">
                                <span class="count_top"><i class="fa fa-times"></i> Cancelados</span>
                                <div class="count">${cancelados}</div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-4 col-6 tile_stats_count">
                                <span class="count_top"><i class="fa fa-exclamation-triangle"></i> Vencidos</span>
                                <div class="count red">${totalVencidos}</div>
                            </div>
                        </div>
                        <!-- /top tiles -->

                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Lembretes por Status
                                        <small>Distribuição dos lembretes</small>
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <canvas id="statusChart" height="280"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-sm-6 col-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Lembretes por Prioridade
                                        <small>Distribuição por prioridade</small>
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <canvas id="prioridadeChart" height="280"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Lembretes por Categoria
                                        <small>Distribuição por categoria</small>
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <canvas id="categoriaChart" height="280"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-sm-6 col-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Lembretes Criados por Mês
                                        <small>Últimos 12 meses</small>
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <canvas id="mensalChart" height="280"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Lembretes Vencidos
                                        <small>Lembretes pendentes com data/hora já passada</small>
                                        </h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <c:choose>
                                            <c:when test="${!empty vencidos}">
                                                <div class="table-responsive">
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>Título</th>
                                                                <th>Descrição</th>
                                                                <th>Data/Hora</th>
                                                                <th>Prioridade</th>
                                                                <th>Categoria</th>
                                                                <th>Ações</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="lembrete" items="${vencidos}">
                                                                <tr class="danger">
                                                                    <td>${lembrete.titulo}</td>
                                                                    <td>${lembrete.descricao != null ? lembrete.descricao : ''}</td>
                                                                    <td>${lembrete.dataHora.toString()}</td>
                                                                    <td>
                                                                        <span class="badge prioridade-${lembrete.prioridade}">
                                                                            ${lembrete.prioridade}
                                                                        </span>
                                                                    </td>
                                                                    <td>${lembrete.categoria != null ? lembrete.categoria : 'Sem categoria'}</td>
                                                                    <td>
                                                                        <a href="lembretes?action=edit&id=${lembrete.id}" class="btn btn-info btn-xs">
                                                                            <i class="fa fa-pencil"></i> Editar
                                                                        </a>
                                                                        <a href="lembretes?action=concluir&id=${lembrete.id}" class="btn btn-success btn-xs">
                                                                            <i class="fa fa-check"></i> Concluir
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-center">Nenhum lembrete vencido.</p>
                                            </c:otherwise>
                                        </c:choose>
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
<!-- Chart.js -->
<script src="${pageContext.request.contextPath}/assets/vendors/Chart.js/dist/Chart.min.js"></script>

<!-- Custom Theme Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/custom.min.js"></script>

<script>
    // Gráfico de Status (Pizza)
    var ctxStatus = document.getElementById('statusChart').getContext('2d');
    var statusChart = new Chart(ctxStatus, {
        type: 'pie',
        data: {
            labels: ['Pendentes', 'Concluídos', 'Cancelados'],
            datasets: [{
                data: [${pendentes}, ${concluidos}, ${cancelados}],
                backgroundColor: [
                    '#337ab7',
                    '#5cb85c',
                    '#999999'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    // Gráfico de Prioridade (Pizza)
    var ctxPrioridade = document.getElementById('prioridadeChart').getContext('2d');
    var prioridadeChart = new Chart(ctxPrioridade, {
        type: 'pie',
        data: {
            labels: ['Alta', 'Média', 'Baixa'],
            datasets: [{
                data: [${altaPrioridade}, ${mediaPrioridade}, ${baixaPrioridade}],
                backgroundColor: [
                    '#d9534f',
                    '#f0ad4e',
                    '#5cb85c'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    // Gráfico de Categoria (Barras)
    <c:set var="categoriasLabels" value=""/>
    <c:set var="categoriasData" value=""/>
    <c:forEach var="cat" items="${porCategoria}" varStatus="loop">
        <c:set var="categoriasLabels" value="${categoriasLabels}${loop.first ? '' : ','}${cat[0]}"/>
        <c:set var="categoriasData" value="${categoriasData}${loop.first ? '' : ','}${cat[1]}"/>
    </c:forEach>
    
    var ctxCategoria = document.getElementById('categoriaChart').getContext('2d');
    var categoriaChart = new Chart(ctxCategoria, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="cat" items="${porCategoria}" varStatus="loop">'${cat[0]}'${loop.last ? '' : ','}</c:forEach>],
            datasets: [{
                label: 'Lembretes',
                data: [<c:forEach var="cat" items="${porCategoria}" varStatus="loop">${cat[1]}${loop.last ? '' : ','}</c:forEach>],
                backgroundColor: 'rgba(54, 162, 235, 0.6)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    // Gráfico Mensal (Linha)
    var ctxMensal = document.getElementById('mensalChart').getContext('2d');
    var mensalChart = new Chart(ctxMensal, {
        type: 'line',
        data: {
            labels: [<c:forEach var="mes" items="${estatisticasMensais}" varStatus="loop">'${mes[0]}'${loop.last ? '' : ','}</c:forEach>],
            datasets: [{
                label: 'Lembretes Criados',
                data: [<c:forEach var="mes" items="${estatisticasMensais}" varStatus="loop">${mes[1]}${loop.last ? '' : ','}</c:forEach>],
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderWidth: 2,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
</script>

</body>
</html>

