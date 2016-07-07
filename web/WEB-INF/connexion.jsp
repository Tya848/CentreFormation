<%-- 
    Document   : connexion
    Created on : 29 juin 2016, 09:39:28
    Author     : macbookpro
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Connectez vous!</h1>
        <form action="connexion" method="POST">
            
     
                Login : <input type="text" name="login"  /> 
            
                <br>           
                Mot de passe : <input type="text"  name="mdp" />           
                     
                <br>
                <c:if test="${erreurCompte != null}">
                    ${erreurCompte}
                </c:if> 
                <c:if test="${erreur != null}">
                    <span >${erreur}</span>
                </c:if> 
                <br>
                <button name="action" value="set">Connecter</button>
            </c:if> 
        </form>           
    </body>
</html>
