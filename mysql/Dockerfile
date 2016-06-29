FROM mysql:5.6.31
COPY ./my.cnf /etc/mysql/conf.d/
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql", "--lower_case_table_names=1"]
