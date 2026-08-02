/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,jsx}"],
  theme: {
    extend: {
      fontFamily: { sans: ["Inter", "system-ui", "sans-serif"] },
      colors: {
        // SMART MANAGER brand system — these are the only brand colours.
        // Status colours (amber warn, red danger, blue info) stay separate:
        // they carry meaning, not identity, and flattening them to green
        // would cost the person the ability to tell a warning from a total.
        brand: {
          DEFAULT: "#16A34A",   // primary green
          light:   "#22C55E",   // secondary green
          mint:    "#DCFCE7",   // mint tint
          surface: "#F8FAFC",   // light background
          line:    "#E5E7EB",   // soft gray
          ink:     "#111827",   // dark text
        },
      },
    },
  },
  plugins: [],
};
