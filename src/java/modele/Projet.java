package modele;

import java.sql.Date;
import java.sql.SQLException;

/**
 *
 * @author macbookpro
 */
public class Projet {
    private int id;

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
    private int id_createur;
    private int id_promotion;
    private Date creerDate;
    private String sujet;
    private String titre;
    private Date dateLimite;

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
        
    }
    
    public static Projet getById(int id) {
        throw new UnsupportedOperationException("pas implemente");
    }
}
