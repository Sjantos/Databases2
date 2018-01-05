/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd2;

import gui.JDialogLogin;
import gui.JFrameManager;
import gui.JFrameSeller;
import gui.JFrameStorekeeper;
import static java.lang.System.exit;
import javax.swing.JFrame;

/**
 *
 * @author s.jantos
 */
public class BD2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        DBConnect connect = new DBConnect();
        int loggedEmployee = 0;
		
//		Testowi pracownicy
//		login		haslo
//		admin 		admin
//		sprzedawca 	hajs
//		magazynier 	butelki

        //mainFrame created only for being parent for JDialog
        JFrame tmpMainFrame = new JFrame();
        JDialogLogin dlg = new JDialogLogin(tmpMainFrame, true, connect);
        loggedEmployee = dlg.ShowDialog();
//        System.out.println("zwrocono:"+loggedEmployee);
	tmpMainFrame.dispose();
        //Now loggedEmployee has privilage number to open proper window
        int privilege = connect.GetPrivileges(loggedEmployee);
        switch(privilege)
        {
            case 1:
                JFrameManager managerFrame = new JFrameManager(connect, loggedEmployee);
                managerFrame.setVisible(true);
                break;
            case 2:
                JFrameSeller sellerFrame = new JFrameSeller(connect, loggedEmployee);
                sellerFrame.setVisible(true);
                break;
            case 3:
                JFrameStorekeeper storekeeperFrame = new JFrameStorekeeper(connect, loggedEmployee);
                storekeeperFrame.setVisible(true);
                break;
            default:
                exit(0);
                break;
        }
    }
}
