*** Settings ***
Documentation        Gerenciando a massa de testes atraves do banco de dados

Library        DatabaseLibrary

*** Keywords ***
Connect To Postgres
    Connect To Database        psycopg2
    ...                        xnmxcwbf
    ...                        xnmxcwbf
    ...                        PFX-ysb3sQsgHZXKBCYgFb2AZXpKoi1M
    ...                        kesavan.db.elephantsql.com
    ...                        5432

Select Student Where Email
    [Arguments]            ${email}

    ${query}        Set Variable
    ...             SELECT * FROM public.students where email = '${email}';

    ${result}       Query           ${query}

    [Return]    ${result}[0]

Delete Enroll By Email
    [Arguments]    ${email}

    ${user}        Select Student Where Email    ${email}

    ${query}        Set Variable
    ...             DELETE FROM public.enrollments WHERE student_id = '${user}[0]';

    Execute SQL String    ${query}

Delete Student By Email
    [Arguments]        ${email}

    ${query}    Set Variable
    ...         DELETE FROM public.students WHERE email = '${email}';

    Execute Sql String    ${query}

# Helpers
Reset Student
    [Arguments]               ${email}
    
    Connect To Postgres
    Delete Student By Email    ${email}
    Disconnect from Database