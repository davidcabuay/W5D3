PRAGMA foreign_keys = ON;

DROP table if exists users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP table if exists questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP table if exists question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP table if exists replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    
    FOREIGN KEY (subject_question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP table if exists question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    
    
    
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
); 

INSERT INTO 
    users (fname, lname)
VALUES
    ('Janny', 'Zhao'),
    ('David', 'Cowboy');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Title 1', 'Body 1', (SELECT id FROM users WHERE fname = 'Janny')),
    ('Title 2', 'Body 2', (SELECT id FROM users WHERE fname = 'David'));

INSERT INTO
    question_follows (question_id, user_id)
VALUES
    (1,2),
    (2,1);

INSERT INTO
    replies (subject_question_id, parent_reply_id, user_id, body)
VALUES  
    (1, 2, 1, 'reply 1'),
    (2, 1, 2, 'reply 2');

INSERT INTO
    question_likes (question_id, user_id)
VALUES 
    (1, 2),
    (2, 1);
