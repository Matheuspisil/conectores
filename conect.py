import mysql.connector

config = {
    'user': 'seu_usuario',
    'password': 'sua_senha',
    'host': 'seu_host',
    'database': 'seu_banco_de_dados'
}

conn = mysql.connector.connect(**config)

cursor = conn.cursor()

cursor.execute("SELECT * FROM tabela")
result = cursor.fetchall()
print(result)
cursor.close()
conn.close()
