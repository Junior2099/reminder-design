<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema de Lembretes - Login</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/assets/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="${pageContext.request.contextPath}/assets/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/assets/css/custom.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style-extra-bs4.css" rel="stylesheet">
</head>

<body class="login">
<div>
    <a class="hiddenanchor" id="signup"></a>
    <a class="hiddenanchor" id="signin"></a>

    <div class="login_wrapper">
        <div class="animate form login_form">
            <section class="login_content">
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <h1><i class="fa fa-bell"></i> Sistema de Lembretes</h1>
                    <h2>Gerencie seus lembretes</h2>
                    
                    <% if (request.getAttribute("erro") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            ${erro}
                        </div>
                    <% } %>
                    
                    <div>
                        <input type="text" name="username" class="form-control" placeholder="Usuário" required=""/>
                    </div>
                    <div>
                        <input type="password" name="password" class="form-control" placeholder="Senha" required=""/>
                    </div>
                    <div class="row">
                        <div class="col-6 text-left">
                            <button type="submit" class="btn btn-primary submit">Entrar</button>
                        </div>
                        <div class="col-6 text-right">
                            <a class="btn btn-secondary reset_pass" href="javascript:;">Esqueceu a senha?</a>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <div class="clearfix"></div>
                        <br/>

                        <div>
                            <h1><i class="fa fa-bell"></i> Sistema de Lembretes</h1>
                            <p>Sistema de Gerenciamento de Lembretes - ©2025 Todos os direitos reservados</p>
                            <p><small>Usuário padrão: <strong>admin</strong> / Senha: <strong>admin</strong></small></p>
                        </div>
                    </div>
                </form>
            </section>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/assets/vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>

