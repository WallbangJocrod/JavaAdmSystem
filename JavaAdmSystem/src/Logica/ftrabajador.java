/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Datos.vtrabajador;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Raimon
 */
public class ftrabajador {
    
    private conexion mysql=new conexion();
    private Connection cn=mysql.conectar();
    private String sSQL="";
    public Integer totalregistros;
    
    
    public DefaultTableModel mostrar(String buscar)
    {
        DefaultTableModel modelo;
        
        String [] titulos = {"ID", "Nombre", "Direccion", "Sexo", "Acceso", "Contraseña", "Telefono", "Correo"};
        
        String [] registro = new String [8];
        
        totalregistros=0;
        
        modelo= new DefaultTableModel(null, titulos);
        
        sSQL="select * from trabajador where id_trabajador like '%" + buscar + "%' order  by id_trabajador";
        
        try {
            Statement st= cn.createStatement();
            ResultSet rs=st.executeQuery(sSQL);
            
            while(rs.next())
            {
                registro [0]= rs.getString("id_trabajador");
                registro [1]= rs.getString("nombre");
                registro [2]= rs.getString("direccion");
                registro [3]= rs.getString("sexo");
                registro [4]= rs.getString("acceso");
                registro [5]= rs.getString("contraseña");
                registro [6]= rs.getString("telefono");
                registro [7]= rs.getString("correo");
                
                totalregistros= totalregistros+1;
                modelo.addRow(registro);
            }
            
            return modelo;
            
        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }  
    }
    
            
        public boolean insertar (vtrabajador dts)
        {
            sSQL="Insert into trabajador (id_trabajador, nombre, direccion, sexo, acceso, contraseña, telefono, correo)" + "values (?,?,?,?,?,?,?,?)";
            try {
                
                PreparedStatement pst=cn.prepareStatement(sSQL);
                pst.setString(1, dts.getId_trabajador());
                pst.setString(2, dts.getNombre());
                pst.setString(3, dts.getDireccion());
                pst.setString(4, dts.getSexo());
                pst.setString(5, dts.getAcceso());
                pst.setString(6, dts.getContraseña());
                pst.setString(7, dts.getTelefono());
                pst.setString(8, dts.getCorreo());
                
                int n=pst.executeUpdate();
                
                if(n!=0)
                {
                   return true; 
                }
                else
                {
                    return false;
                }
                
            } catch (Exception e) {
                JOptionPane.showConfirmDialog(null, e);
                return false;
            }
        }
    
        public boolean editar (vtrabajador dts)
        {
            sSQL= "Update trabajador set nombre=?, direccion=?, sexo=?, contraseña=?, telefono=?, correo=?" + "where id_trabajador=?";
            
            try {
                
                PreparedStatement pst=cn.prepareStatement(sSQL);
                pst.setString(1, dts.getNombre());
                pst.setString(2, dts.getDireccion());
                pst.setString(3, dts.getSexo());
                pst.setString(5, dts.getContraseña());
                pst.setString(6, dts.getTelefono());
                pst.setString(7, dts.getCorreo());
                
                int n=pst.executeUpdate();
                
                if(n!=0)
                {
                   return true; 
                }
                else
                {
                    return false;
                }
                
                
            } catch (Exception e) {
                JOptionPane.showConfirmDialog(null, e);
                return false;
            }
        }
                
        public boolean eliminar (vtrabajador dts)
        {
            sSQL="delete from trabajador where id_trabajador=?";
            try {
                
                PreparedStatement pst=cn.prepareStatement(sSQL);
                pst.setString(1, dts.getId_trabajador());

                int n=pst.executeUpdate();
                
                if(n!=0)
                {
                   return true; 
                }
                else
                {
                    return false;
                }
                
            } catch (Exception e) {
                JOptionPane.showConfirmDialog(null, e);
                return false;
            }
        }
}
