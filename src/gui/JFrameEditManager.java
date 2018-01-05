
package gui;

import bd2.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;


public class JFrameEditManager extends javax.swing.JFrame {
    DBConnect connect;
    Connection con;
    Statement st;
    int id = 0;
    Boolean verifyId;
    Boolean canBeExecuted = true;
    public JFrameEditManager(DBConnect conn) {
        connect = conn;
        con = connect.getConnection();
        initComponents();
        verifyId = false;
        Boolean canBeExecuted = true;
    }

    public void end()
    {
        setVisible(false);
        dispose();
    }
    public void getId()
    {
        for(int i = 0 ; i < Id.getText().length() ; i++)
        {
            if(Id.getText().charAt(i) < 48 || Id.getText().charAt(i) > 57)
               canBeExecuted = false; 
                
        }
        if(Id.getText().equals(""))
        {
                canBeExecuted = false;

        }
        if( canBeExecuted == true)
        {
            id = Integer.parseInt(Id.getText());
        }
    }
        
        
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        EditDrink = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();
        EditWorker = new javax.swing.JButton();
        EditProvider = new javax.swing.JButton();
        jButton5 = new javax.swing.JButton();
        EditClient = new javax.swing.JButton();
        Close = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        Id = new javax.swing.JTextField();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        EditDrink.setText("Edit Drink");
        EditDrink.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                EditDrinkActionPerformed(evt);
            }
        });

        jButton2.setText("jButton1");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        EditWorker.setText("Edit Wroker");
        EditWorker.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                EditWorkerActionPerformed(evt);
            }
        });

        EditProvider.setText("Edit Provider");
        EditProvider.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                EditProviderActionPerformed(evt);
            }
        });

        jButton5.setText("jButton1");
        jButton5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton5ActionPerformed(evt);
            }
        });

        EditClient.setText("Edit Client");
        EditClient.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                EditClientActionPerformed(evt);
            }
        });

        Close.setText("Close");
        Close.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                CloseActionPerformed(evt);
            }
        });

        jLabel1.setText("Id:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(Id)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(EditWorker, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(EditDrink, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jButton5, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(EditClient, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(EditProvider, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(58, 58, 58)
                        .addComponent(Close, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel1))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(Id, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(22, 22, 22)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(EditDrink, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(EditWorker, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(EditProvider, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(EditClient, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton5, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(Close, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void CloseActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_CloseActionPerformed
        // TODO add your handling code here:
        end();
    }//GEN-LAST:event_CloseActionPerformed

    private void EditWorkerActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_EditWorkerActionPerformed
        // TODO add your handling code here:
         canBeExecuted = true;
        getId();
        Statement st = null;
        ResultSet rs = null;
        try {
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM employees;");
            
            while(rs.next())
            {
                if(id == rs.getInt(1))
                {
                      verifyId = true;      
                }
            }
            } catch (SQLException ex) {
            Logger.getLogger(JFrameEditDrink.class.getName()).log(Level.SEVERE, null, ex);
            }
            if(verifyId == false)
            {
                JOptionPane.showMessageDialog(null,"Bledny indeks.","Error", JOptionPane.ERROR_MESSAGE);
                Id.removeAll();
            } else
            {
                JFrameEditWorker EditWorkerFrame = new JFrameEditWorker(connect,id);
                EditWorkerFrame.setVisible(true);
                           end();
                
            }
           Id.setText("");
        
    }//GEN-LAST:event_EditWorkerActionPerformed

    private void EditDrinkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_EditDrinkActionPerformed
        // TODO add your handling code here:
         canBeExecuted = true;
        getId();
                Statement st = null;
        ResultSet rs = null;
        try {
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM drinks;");
            
            while(rs.next())
            {
                if(id == rs.getInt(1))
                {
                      verifyId = true;      
                }
            }
            } catch (SQLException ex) {
            Logger.getLogger(JFrameEditDrink.class.getName()).log(Level.SEVERE, null, ex);
            }
            if(verifyId == false)
            {
                JOptionPane.showMessageDialog(null,"Bledny indeks.","Error", JOptionPane.ERROR_MESSAGE);
            } else
            {
                JFrameEditDrink EditDrinkFrame = new JFrameEditDrink(connect,id);
                EditDrinkFrame.setVisible(true);
                 end();
            }
           Id.setText("");
    }//GEN-LAST:event_EditDrinkActionPerformed

    private void EditClientActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_EditClientActionPerformed

         canBeExecuted = true;
        getId();
                Statement st = null;
        ResultSet rs = null;
        try {
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM clients;");
            
            while(rs.next())
            {
                if(id == rs.getInt(1))
                {
                      verifyId = true;      
                }
            }
            } catch (SQLException ex) {
            Logger.getLogger(JFrameEditClient.class.getName()).log(Level.SEVERE, null, ex);
            }
            if(verifyId == false)
            {
                JOptionPane.showMessageDialog(null,"Bledny indeks.","Error", JOptionPane.ERROR_MESSAGE);
            } else
            {
                JFrameEditClient EditDrinkFrame = new JFrameEditClient(connect,id);
                EditDrinkFrame.setVisible(true);
                end();
            }
           Id.setText("");
    }//GEN-LAST:event_EditClientActionPerformed

    private void EditProviderActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_EditProviderActionPerformed

         canBeExecuted = true;
        getId();
                Statement st = null;
        ResultSet rs = null;
        try {
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM providers;");
            
            while(rs.next())
            {
                if(id == rs.getInt(1))
                {
                      verifyId = true;      
                }
            }
            } catch (SQLException ex) {
            Logger.getLogger(JFrameEditProvider.class.getName()).log(Level.SEVERE, null, ex);
            }
            if(verifyId == false)
            {
                JOptionPane.showMessageDialog(null,"Bledny indeks.","Error", JOptionPane.ERROR_MESSAGE);
            } else
            {
                JFrameEditProvider EditDrinkFrame = new JFrameEditProvider(connect,id);
                EditDrinkFrame.setVisible(true);
                end();
            }
           Id.setText("");
    }//GEN-LAST:event_EditProviderActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        // TODO add your handling code here:
        getId();
        
        end();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
        // TODO add your handling code here:
        getId();
        
        end();
    }//GEN-LAST:event_jButton5ActionPerformed



    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Close;
    private javax.swing.JButton EditClient;
    private javax.swing.JButton EditDrink;
    private javax.swing.JButton EditProvider;
    private javax.swing.JButton EditWorker;
    private javax.swing.JTextField Id;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton5;
    private javax.swing.JLabel jLabel1;
    // End of variables declaration//GEN-END:variables
}
