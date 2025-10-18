import './styles/App.css'

function App() {
  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const data = Object.fromEntries(formData);

    // In a real implementation, this would send to your backend
    fetch('/.netlify/functions/submit-lead', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
      window.location.href = '/thank-you.html';
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Er is iets misgegaan. Probeer het opnieuw.');
    });
  };

  return (
    <>
      <header className="header">
        <div className="header-content">
          <div className="logo">RecruitmentAPK</div>
          <nav>
            <span style={{color: '#667eea'}}>✓ Gratis Assessment</span>
          </nav>
        </div>
      </header>

      <section className="hero">
        <div className="container">
          <h1>Recruitment APK Test</h1>
          <p className="hero-subtitle">Verbeter Uw Recruitment Performance</p>
          <p className="hero-description">
            Ontdek in 5 minuten hoe u uw recruitment proces kunt optimaliseren
          </p>
        </div>
      </section>

      <section className="container">
        <div className="benefits-grid">
          <div className="benefit-card">
            <div className="benefit-icon">📊</div>
            <h3>Data-Driven Analyse</h3>
            <p>Krijg inzicht in uw recruitment metrics en KPIs</p>
          </div>
          <div className="benefit-card">
            <div className="benefit-icon">💰</div>
            <h3>ROI Berekening</h3>
            <p>Ontdek uw werkelijke recruitment kosten en besparingen</p>
          </div>
          <div className="benefit-card">
            <div className="benefit-icon">🎯</div>
            <h3>Actieplan</h3>
            <p>Ontvang een gepersonaliseerd verbeterplan</p>
          </div>
        </div>
      </section>

      <section className="container">
        <div className="form-section">
          <h2 className="form-title">Start Uw Gratis Assessment</h2>
          <p className="form-subtitle">Vul het formulier in en ontvang binnen 24 uur uw persoonlijke rapport</p>

          <form id="apk-form" onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="company">Bedrijfsnaam *</label>
              <input type="text" id="company" name="company" required />
            </div>

            <div className="form-group">
              <label htmlFor="name">Uw Naam *</label>
              <input type="text" id="name" name="name" required />
            </div>

            <div className="form-group">
              <label htmlFor="email">E-mailadres *</label>
              <input type="email" id="email" name="email" required />
            </div>

            <div className="form-group">
              <label htmlFor="phone">Telefoonnummer</label>
              <input type="tel" id="phone" name="phone" />
            </div>

            <div className="form-group">
              <label htmlFor="employees">Aantal Medewerkers *</label>
              <select id="employees" name="employees" required>
                <option value="">Selecteer...</option>
                <option value="1-10">1-10</option>
                <option value="11-50">11-50</option>
                <option value="51-200">51-200</option>
                <option value="201-500">201-500</option>
                <option value="500+">500+</option>
              </select>
            </div>

            <div className="form-group">
              <label htmlFor="sector">Sector *</label>
              <select id="sector" name="sector" required>
                <option value="">Selecteer uw sector...</option>
                <option value="IT">IT & Technology</option>
                <option value="Finance">Finance & Banking</option>
                <option value="Healthcare">Healthcare</option>
                <option value="Manufacturing">Manufacturing</option>
                <option value="Retail">Retail & E-commerce</option>
                <option value="Other">Anders</option>
              </select>
            </div>

            <button type="submit" className="cta-button">
              Start Gratis Assessment →
            </button>

            <p className="form-footer">
              ✓ Geen verplichtingen &nbsp; ✓ 100% Gratis &nbsp; ✓ Direct resultaat
            </p>
          </form>
        </div>
      </section>

      <section>
        <div className="social-proof">
          <h3>Vertrouwd door 500+ Nederlandse Bedrijven</h3>
          <div className="stats-row">
            <div className="stat">
              <div className="stat-number">87%</div>
              <div className="stat-label">Verbeterde hire quality</div>
            </div>
            <div className="stat">
              <div className="stat-number">-43%</div>
              <div className="stat-label">Lagere recruitment kosten</div>
            </div>
            <div className="stat">
              <div className="stat-number">2.5x</div>
              <div className="stat-label">Sneller hiring proces</div>
            </div>
          </div>
        </div>
      </section>
    </>
  )
}

export default App