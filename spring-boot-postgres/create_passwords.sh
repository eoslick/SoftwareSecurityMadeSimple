# Generate secure random passwords
POSTGRES_ROOT_PASSWORD=$(openssl rand -base64 24 | tr -dc 'a-zA-Z0-9' | head -c12)
POSTGRES_DB_PASSWORD=$(openssl rand -base64 24 | tr -dc 'a-zA-Z0-9' | head -c12)

# Export passwords as environment variables
export POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD
export POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD

# Update 01.sql and 02_password_update.sql files with the passwords
sed -i.bak "s|'VAADIN_PASSWORD'|'$POSTGRES_DB_PASSWORD'|g" ./sql/01.sql
sed -i.bak "s|'POSTGRES_PASSWORD'|'$POSTGRES_ROOT_PASSWORD'|g" ./02_password_update.sql
sed -i.bak "s|'VAADIN_PASSWORD'|'$POSTGRES_DB_PASSWORD'|g" ./02_password_update.sql

# Remove backup files
rm ./sql/01.sql.bak
rm ./02_password_update.sql.bak

# Store passwords into .env file
echo "POSTGRES_PASSWORD=$POSTGRES_DB_PASSWORD" > .env
echo "VAADIN_PASSWORD=$POSTGRES_DB_PASSWORD" >> .env
