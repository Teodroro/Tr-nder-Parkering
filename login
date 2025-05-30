<!DOCTYPE html>
<html lang="no">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Logg inn / Registrer</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f0f4f8;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      background: white;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 400px;
    }

    .tab-buttons {
      display: flex;
      justify-content: space-around;
      margin-bottom: 20px;
    }

    .tab-buttons button {
      flex: 1;
      padding: 12px;
      border: none;
      background-color: #e6e6e6;
      font-weight: bold;
      cursor: pointer;
      border-radius: 8px 8px 0 0;
      transition: background-color 0.3s ease;
    }

    .tab-buttons button.active {
      background-color: #007bff;
      color: white;
    }

    .form {
      display: none;
      flex-direction: column;
    }

    .form.active {
      display: flex;
    }

    input {
      margin-bottom: 15px;
      padding: 12px;
      font-size: 16px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }

    button.submit-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 12px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button.submit-btn:hover {
      background-color: #0056b3;
    }

    .back-link {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #007bff;
      text-decoration: none;
    }

    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <div class="container">
    <div class="tab-buttons">
      <button id="loginTab" class="active" onclick="showTab('login')">Logg inn</button>
      <button id="registerTab" onclick="showTab('register')">Registrer</button>
    </div>

    <!-- Innlogging -->
    <form id="loginForm" class="form active" onsubmit="event.preventDefault(); alert('Logget inn!');">
      <input type="email" placeholder="E-post" required />
      <input type="password" placeholder="Passord" required />
      <button type="submit" class="submit-btn">Logg inn</button>
    </form>

    <!-- Registrering -->
    <form id="registerForm" class="form" onsubmit="event.preventDefault(); alert('Bruker registrert!');">
      <input type="text" placeholder="Fullt navn" required />
      <input type="email" placeholder="E-post" required />
      <input type="password" placeholder="Passord" required />
      <button type="submit" class="submit-btn">Registrer</button>
    </form>

    <a href="Startside.html" class="back-link">← Tilbake til forsiden</a>
  </div>

  <script>
    function showTab(tab) {
      document.getElementById('loginForm').classList.remove('active');
      document.getElementById('registerForm').classList.remove('active');
      document.getElementById('loginTab').classList.remove('active');
      document.getElementById('registerTab').classList.remove('active');

      if (tab === 'login') {
        document.getElementById('loginForm').classList.add('active');
        document.getElementById('loginTab').classList.add('active');
      } else {
        document.getElementById('registerForm').classList.add('active');
        document.getElementById('registerTab').classList.add('active');
      }
    }
  </script>

</body>
</html>
