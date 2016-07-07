package modele;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author macbookpro
 */
public class Projet {
    private int id;
    private int id_createur;
    private int id_promotion;
    private Date creerDate;
    private String sujet;
    private String titre;
    private Date dateLimite;

    public Projet() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
    public String getSujet() {
        return sujet;
    }

    public void setSujet(String sujet) {
        this.sujet = sujet;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Date getDateLimite() {
        return dateLimite;
    }

    public void setDateLimite(Date dateLimite) {
        this.dateLimite = dateLimite;
    }
   

    public int getId() {
        return id;
    }

    public int getId_createur() {
        return id_createur;
    }

    public void setId_createur(int id_createur) {
        this.id_createur = id_createur;
    }

    public int getId_promotion() {
        return id_promotion;
    }

    public void setId_promotion(int id_promotion) {
        this.id_promotion = id_promotion;
    }

    public Date getCreerDate() {
        return creerDate;
    }

    public void setCreerDate(Date creerDate) {
        this.creerDate = creerDate;
    }

    public Projet(int id, int id_createur, int id_promotion, String sujet, String titre, Date dateLimite) {
        this.id = id;
        this.id_createur = id_createur;
        this.id_promotion = id_promotion;
        this.sujet = sujet;
        this.titre = titre;
        this.dateLimite = dateLimite;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
    public void insert() throws SQLException {
        
     
        Connection connection = Database.getConnection();
        // Commencer une transaction
        connection.setAutoCommit(false);
        try {
            // Inserer le produit
            String sql = "INSERT INTO projet(id_promotion, id_createur, sujet, titre, date_creation, date_limite) VALUES(?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id_promotion);
            stmt.setInt(2, id_createur);
            stmt.setString(3, sujet);
            stmt.setString(4, titre);
            stmt.setDate(5, creerDate);
            stmt.setDate(6, dateLimite);
            stmt.executeUpdate();
            stmt.close();
            // Recuperer le id
            Statement maxStmt = connection.createStatement();
            ResultSet rs = maxStmt.executeQuery("SELECT MAX(id_projet) AS id FROM projet");
            rs.next();
            id = rs.getInt("id");
            rs.close();
            maxStmt.close();
            // Valider
            connection.commit();
        } catch (SQLException exc) {
            connection.rollback();
            exc.printStackTrace();
            throw exc;
        } finally {
            connection.close();
        
        } 
    }
    
    public static Projet getById(int id) {
        throw new UnsupportedOperationException("pas implemente");
    }
}
