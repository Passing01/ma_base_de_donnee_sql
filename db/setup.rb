require 'sqlite3'

#Creation d'un objet SQLite3::Database qui represente la base de données
# si le fichier specifique n'existe pas il sera creer
db = SQLite3::Database.new 'blog.db'

#Creation de la table <<users>> avec un Id auto-incrementé et un nom unique
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
  );
SQL

#creation de la table <<articles>> avec un Id auto-incrementé, un titre, un contenu
# et une reference a l'Id de l'utilisateur qui a cree l'article
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
  );
SQL
# creation de la table <<categories>> avec un Id auto-incrementé et un nom unique
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
  );
SQL

# creation de la table <<tags>> avec Id auto-incrementé, un nom unique et une couleur
db.execute <<-SQL
 CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  color TEXT NOT NULL
 );
SQL

# creation de la table <<articles_categories>> pour representer la relation
# plusieurs à plusieurs entres les articles et les categories
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS articles_categories (
    article_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (article_id, category_id),
    FOREIGN KEY (article_id) REFERENCES articles (id),
    FOREIGN KEY (category_id) REFERENCES categories (id)
  );
SQL

# creation de la table <<tags_categories>> pour representer la relation plusieurs
# à plusieurs entre les categories et les tags
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS tags_categories (
    tag_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (tag_id, category_id),
    FOREIGN KEY (tag_id) REFERENCES tags (id),
    FOREIGN KEY (category_id) REFERENCES categories (id)
  );
SQL

# Insertion d'un utilisateur dans la table <<users>>
db.execute "INSERT INTO users (name) VALUES ('Johne Doe')"

# Insertion d'un article dans la table <<articles>> avec une refernce à l'Id de l'utilisateur
db.execute "INSERT INTO articles (title, content, user_id) VALUES ('Mon premier article', 'Contenu de mon premier article', 1)"

# Insertion d'une categorie dans la table <<categories>>
db.execute "INSERT INTO categories (name) VALUES ('Development web')"

# Insertion d'un tag dans la table <<tags>>
db.execute "INSERT INTO tags (name, color) VALUES ('Ruby', '#FF0000')"

# Insertion d'une relation entre l'article et la categorie dans la table <<articles_categories>>
db.execute "INSERT INTO articles_categories (article_id, category.id) VALUES (1, 1)"

# Insertion d'une relation entre le tag et la categorie dans la table <<tags_categories>>
db.execute "INSERT INTO tags_categories (tag_id, category_id) VALUES (1, 1)"