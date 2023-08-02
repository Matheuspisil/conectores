#include <mysql_driver.h>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/connection.h>
#include <cppconn/statement.h>
#include <cppconn/resultset.h>

int main() {
    std::string url = "tcp://seu_host:seu_porta";
    std::string user = "seu_usuario";
    std::string password = "sua_senha";

    try {
        sql::Driver* driver = get_driver_instance();
        sql::Connection* conn = driver->connect(url, user, password);

      
        sql::Statement* stmt = conn->createStatement();

       
        sql::ResultSet* rs = stmt->executeQuery("SELECT * FROM tabela");

        while (rs->next()) {
            std::cout << rs->getString("coluna") << std::endl;
        }
        delete rs;
        delete stmt;
        delete conn;
    } catch (sql::SQLException& e) {
        std::cout << "Erro: " << e.what() << std::endl;
    }

    return 0;
}
