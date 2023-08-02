section .data
    database_name   db  "example.db",0
    query           db  "SELECT * FROM tabela",0
    row             db  100 dup 0

section .bss
    db_handle       resd 1
    stmt_handle     resd 1
    result_code     resd 1

section .text
    extern sqlite3_open, sqlite3_prepare_v2, sqlite3_step, sqlite3_finalize, sqlite3_close

global _start

_start:
    ; Abrir conexão com o banco de dados
    push dword database_name
    push dword db_handle
    call sqlite3_open
    add esp, 8

    ; Preparar a consulta
    push dword query
    push dword -1
    push dword stmt_handle
    push dword 0 ; Preencher com zero para indicar que não há texto extra na consulta
    call sqlite3_prepare_v2
    add esp, 16

fetch_loop:
    ; Executar a consulta
    call sqlite3_step
    cmp eax, 100
    je done ; Se não há mais linhas, pule para a etiqueta 'done'

    ; Obter os dados da linha atual
    lea ebx, [row]
    mov ecx, stmt_handle
    call sqlite3_column_text
    mov esi, eax ; Armazenar o ponteiro para a string

    ; Exibir os dados da linha atual
    mov eax, 4 ; Número do sistema de chamada para 'write'
    mov ebx, 1 ; Descritor de arquivo para 'stdout'
    mov edx, eax ; Tamanho da string a ser exibida
    int 0x80

    jmp fetch_loop ; Repetir o loop para buscar mais linhas

done:
    ; Finalizar a consulta
    mov ecx, stmt_handle
    call sqlite3_finalize
    ; Fechar a conexão com o banco de dados
    mov ecx, db_handle
    call sqlite3_close

    ; Encerrar o programa
    mov eax, 1 ; Número do sistema de chamada para 'exit'
    xor ebx, ebx ; Código de saída 0
    int 0x80
