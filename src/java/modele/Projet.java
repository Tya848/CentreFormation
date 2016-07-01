/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import java.sql.SQLException;

/**
 *
 * @author macbookpro
 */
public class Projet {
    private int id;

    public int getId() {
        return id;
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
