# clone the repo (if not already)
git clone https://github.com/EzraMpapi/Mybuz.git
cd Mybuz

# create branch
git checkout -b add/main-entry

# create src/main.jsx (paste the content above)
mkdir -p src
cat > src/main.jsx <<'EOF'
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './index.css'; // remove or change if you don't have this file

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

# commit and push
git add src/main.jsx
git commit -m "Add React entrypoint: src/main.jsx (fix Vite build error)"
git push -u origin add/main-entry

# create PR (requires GitHub CLI authenticated)
gh pr create --title "Add React entrypoint src/main.jsx" \
  --body "Add the React entrypoint file referenced by index.html to fix Vite build error: Rollup couldn't resolve /src/main.jsx. This adds src/main.jsx which bootstraps the app." \
  --base main --head add/main-entry
