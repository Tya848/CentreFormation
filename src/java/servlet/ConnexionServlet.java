/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modele.Personne;

/**
 *
 * @author macbookpro
 */
@WebServlet(name = "ConnexionServlet", urlPatterns = {"/connexion"})
public class ConnexionServlet extends HttpServlet {

    private static final String VUE = "WEB-INF/connexion.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Passer la main à la JSP
        request.getRequestDispatcher(VUE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login;
        String mdp;
        //boolean formIsValid = true;
         boolean estConnecte = false;
        try {
            
            String action = request.getParameter("action");
            
            HttpSession session = request.getSession();
                //la constance avant la variable parce que action peut être null
                if ("unset".equals(action)) {
                    session.removeAttribute("user");
                    request.removeAttribute("erreurLogin");
                    request.removeAttribute("erreurMdp"); 
                    request.getRequestDispatcher(VUE).forward(request, response);
                }  
                else {
                        // Recupérer                                  
                login = request.getParameter("login");
                mdp = request.getParameter("mdp");
                if (login == null || login.trim().equals("")) {
                    request.setAttribute("erreurLogin", "Le login doit être renseigné");

                } else if (mdp == null || mdp.trim().equals("")) {

                    request.setAttribute("erreurMdp", "Le mot de passe doit être renseigné");
                    //formIsValid = false;
                } else {
                    Personne personne = Personne.getByLoginPwd(login, mdp);
                    if (personne == null) {
                        request.setAttribute("erreurCompte", "Le compte n'existe pas");

                    } else {
                        session.setAttribute("user", personne);
                        estConnecte = true;
                    }
                }
                }
                // request.setAttribute("connexionOK", "Vous êtes connecté");

            }catch (SQLException ex) {
            Logger.getLogger(ConnexionServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("erreur", ex.getMessage());
        }
            String url = (String) request.getSession().getAttribute("url");
            if ( estConnecte && url != null) {
                response.sendRedirect(url);
            } else {
            request.getRequestDispatcher(VUE).forward(request, response);
            }
        }

    }
