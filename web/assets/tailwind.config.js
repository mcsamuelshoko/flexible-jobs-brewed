// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/flexible_jobs_brewed_web.ex",
    "../lib/flexible_jobs_brewed_web/**/*.*ex"
  ],
  theme: {
    extend: {
      // colors: {
      //   fjPrimary: "#4ecdc4",
      //   fjSecondary: "#16504b",
      //   fjAccent: "#afe9ef",
      //   bgLight: "#f2f2f2",
      //   bgDark: "#2f2932",
      //   textDark: "#f7f7f7",
      //   textLight: "#1a1a1a",
      // },
      colors: {
        'fjPrimary':
          { DEFAULT: '#4ecdc4', 50: '#f1fcfa', 100: '#d0f7f1', 200: '#a0efe4', 300: '#69dfd3', 400: '#4ecdc4', 500: '#20aca4', 600: '#178a86', 700: '#176e6c', 800: '#175858', 900: '#174a49', 950: '#072b2c' },
        'fjSecondary':
          { DEFAULT: '#16504b', 100: '#04100f', 200: '#09201e', 300: '#0d302d', 400: '#12403c', 500: '#16504b', 600: '#279087', 700: '#3fcabf', 800: '#7fdcd4', 900: '#bfedea' },
        'fjAccent':
          { DEFAULT: '#afe9ef', 100: '#0e3f45', 200: '#1b7f8a', 300: '#29becf', 400: '#69d5e1', 500: '#afe9ef', 600: '#beedf2', 700: '#cef2f5', 800: '#dff6f9', 900: '#effbfc' },
        'bgLight':
          { DEFAULT: '#f2f2f2', 100: '#303030', 200: '#616161', 300: '#919191', 400: '#c2c2c2', 500: '#f2f2f2', 600: '#f5f5f5', 700: '#f7f7f7', 800: '#fafafa', 900: '#fcfcfc' },
        'textDark':
          { DEFAULT: '#f7f7f7', 100: '#313131', 200: '#636363', 300: '#949494', 400: '#c6c6c6', 500: '#f7f7f7', 600: '#f9f9f9', 700: '#fafafa', 800: '#fcfcfc', 900: '#fdfdfd' },
        'textLight':
          { DEFAULT: '#1a1a1a', 100: '#050505', 200: '#0a0a0a', 300: '#0f0f0f', 400: '#141414', 500: '#1a1a1a', 600: '#474747', 700: '#757575', 800: '#a3a3a3', 900: '#d1d1d1' },
        'bgDark':
          { DEFAULT: '#2f2932', 100: '#09080a', 200: '#131114', 300: '#1c191e', 400: '#262128', 500: '#2f2932', 600: '#5b4f60', 700: '#86758e', 800: '#aea3b4', 900: '#d7d1d9' } }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
