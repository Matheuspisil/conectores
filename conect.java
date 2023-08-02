import java.sql.*;

public class Main {
    public static void main(String[] args) {
        String url = "jdbc:mysql://seu_host/seu_banco_de_dados";
        String user = "seu_usuario";
        String password = "sua_senha";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);

            Statement stmt = conn.createStatement();

            String sql = "SELECT * FROM tabela";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                System.out.println(rs.getString("coluna"));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
