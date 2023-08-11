# Generate secure random passwords
POSTGRES_ROOT_PASSWORD=$(openssl rand -base64 24 | tr -dc 'a-zA-Z0-9' | head -c12)
POSTGRES_DB_PASSWORD=$(openssl rand -base64 24 | tr -dc 'a-zA-Z0-9' | head -c12)

# Export passwords as environment variables
export POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD
export POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD

# Update 01.sql and 02_password_update.sql files with the passwords
sed -i.bak "s|'POSTGRES_DB_USER'|'$POSTGRES_DB_USER'|g" ./sql/01.sql
sed -i.bak "s|'POSTGRES_DB_PASSWORD'|'$POSTGRES_DB_PASSWORD'|g" ./sql/01.sql

# Remove backup files
rm ./sql/01.sql.bak

# Store passwords into .env file
echo "POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD" >> .env
echo "POSTGRES_DB_PASSWORD=$POSTGRES_DB_PASSWORD" >> .env
