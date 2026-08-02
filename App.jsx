import { ErrorBoundary } from "./ErrorBoundary.jsx";
import { SmartManager } from "./Shell.jsx";
import { AppLock, GlobalStyles } from "./ui.jsx";

export default function App() {
  return (
    <>
      <GlobalStyles />
      <ErrorBoundary>
        <AppLock>
          <SmartManager />
        </AppLock>
      </ErrorBoundary>
    </>
  );
}
