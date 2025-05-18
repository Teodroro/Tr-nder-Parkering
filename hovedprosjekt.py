from flask import Flask, render_template, request, redirect, url_for, flash
import mariadb

app = Flask(__name__)
app.secret_key = 'supersecretkey'

db_config = {
    'host': 'localhost',
    'user': 'r1',        
    'password': 'parkering2025', 
    'database': 'parkering25',
    'port': 3306
}

def get_db_connection():
    try:
        return mariadb.connect(**db_config)
    except mariadb.Error as e:
        print(f"Feil ved tilkobling til databasen: {e}")
        return None

@app.route('/')
def startside():
    return render_template('startside.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        epost = request.form.get('email')
        passord = request.form.get('password')
        conn = get_db_connection()
        if not conn:
            flash("Databasefeil.")
            return redirect(url_for('login'))

        cursor = conn.cursor()
        cursor.execute("SELECT id, navn FROM brukere WHERE epost = ? AND passord = ?", (epost, passord))
        user = cursor.fetchone()
        conn.close()

        if user:
            flash(f"Velkommen, {user[1]}!")
            return redirect(url_for('oversikt'))
        else:
            flash("Feil e-post eller passord.")
    return render_template('registrering.html')

@app.route('/register', methods=['POST'])
def register():
    navn = request.form.get('name')
    epost = request.form.get('email')
    passord = request.form.get('password')

    conn = get_db_connection()
    if not conn:
        flash("Databasefeil.")
        return redirect(url_for('login'))

    try:
        cursor = conn.cursor()
        cursor.execute("INSERT INTO brukere (navn, epost, passord) VALUES (?, ?, ?)", (navn, epost, passord))
        conn.commit()
        flash("Registrering vellykket! Du kan nå logge inn.")
    except mariadb.Error as e:
        flash(f"Feil under registrering: {e}")
    finally:
        conn.close()

    return redirect(url_for('login'))

@app.route('/oversikt')
def oversikt():
    conn = get_db_connection()
    if not conn:
        flash("Databasefeil.")
        return redirect(url_for('startside'))

    cursor = conn.cursor()
    cursor.execute("SELECT id, plassnummer, etasje, er_opptatt FROM parkeringsplasser")
    raw_data = cursor.fetchall()
    conn.close()

    columns = ['id', 'plassnummer', 'etasje', 'er_opptatt']
    plasser = [dict(zip(columns, row)) for row in raw_data]

    return render_template('parkeringsplasser.html', plasser=plasser)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

