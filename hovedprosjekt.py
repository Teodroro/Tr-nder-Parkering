from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
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


@app.route('/api/update-spot', methods=['POST'])
def update_spot():
    data = request.get_json()
    plassnummer = data.get('plassnummer')
    er_opptatt = data.get('er_opptatt')

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE parkeringsplasser
        SET er_opptatt = %s
        WHERE plassnummer = %s
    """, (int(er_opptatt), plassnummer))
    conn.commit()
    conn.close()

    return jsonify({"status": "ok"}), 200



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

@app.route('/api/status')
def api_status():
    expected = ['A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT plassnummer, er_opptatt FROM parkeringsplasser")
    rows = cursor.fetchall()
    conn.close()

    db_map = {row[0]: row[1] for row in rows}

    full_status = []
    for plass in expected:
        full_status.append({
            "plassnummer": plass,
            "er_opptatt": db_map.get(plass, 0)  # default to ledig (0)
        })

    return jsonify(full_status)



@app.route('/oversikt')
def oversikt():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT plassnummer, er_opptatt FROM parkeringsplasser")
    plasser = cursor.fetchall()
    conn.close()

    data = [{"plassnummer": p[0], "er_opptatt": p[1]} for p in plasser]
    return render_template("parkeringsplasser.html", plasser=data)




if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

