import daisyui from "daisyui";
import { fontFamily } from 'tailwindcss/defaultTheme';

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["../lib/todo_htmex/web/templates/**/*.html.eex"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Kanit', ...fontFamily.sans]
      }
    },
  },
  plugins: [daisyui],
  daisyui: {
    themes: ["dark"]
  },
}

