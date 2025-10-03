<div align="center">

# Todoapp with Elixir & Htmx

Simple todo web app demo with Bandit, Plug and Htmx (no Phoenix).

<img src="priv/static/assets/images/logo.png" width="30%">

<br /><br />

![GitHub License](https://img.shields.io/github/license/emarifer/elixir_htmx_plug_bandit_todoapp) ![Static Badge](https://img.shields.io/badge/Elixir-%3E=1.18-6e4a7e) ![Static Badge](https://img.shields.io/badge/Erlang/OTP-%3E=27-B83998) ![Static Badge](https://img.shields.io/badge/Htmx-%3E=2.0.7-2a7fff)

</div>

<br />

---

### 🚀 Features

<div align="center" style="margin-bottom: 16px;">

<img src="priv/static/assets/images/screenshot-todo_htmex.gif" width="55%">

<br />

</div>

- [x] **General features:** In the world of languages ​​running on the `BEAM VM`, particularly Elixir, the [`Phoenix framework`](https://phoenixframework.org/) shines undisputedly. Based on the enormous capacity for concurrency/parallelism and the ease of implementing distributable applications of `Elixir/Erlang-OTP`, Phoenix combines a whole series of features such as out-of-the-box authentication systems, code generators that reduce boilerplate, [`LiveView`](https://hexdocs.pm/phoenix_live_view/welcome.html) components (`server-side rendering` of pages with the help of `stateful components`), based on `WebSockets` that offer interactivity and real-time features unique among server-side frameworks, easy integration with databases through the integrated `Ecto` library, and much more. All this, combined with the optimizations it possesses that allow for incredible vertical and horizontal scalability (see this [post](https://phoenixframework.org/blog/the-road-to-2-million-websocket-connections)), make it the best web framework on the market. **But what if you just want to create a `microservice` or simply a simple web application?** In this case, Phoenix will be too large, heavy, and "ceremonious." Also, if you're inclined to use the [`Htmx`](https://htmx.org/) library to provide interactivity for your website, you may run into conflict with `LiveView` unless you make some adjustments. On the other hand, Phoenix uses a lot of `metaprogramming` and `macros` to reduce the boilerplate and create its own `DSL`, abstracting away too much of Elixir's code, which might not appeal to you if you want to understand how things work under the hood. The best option, in this case, would be to use `Plug` in conjunction with the `Bandit` server and provide `UI` interactivity by adding `Htmx`.

- [x] **Plug:** [Plug](https://hexdocs.pm/plug/readme.html) is a specification and library for building composable web applications and web server adapters for the `Erlang VM`, similar to `Rack` in `Ruby`. It defines a standard interface for request processing, allowing developers to create modular components called "plugs" that can inspect, modify, or halt requests as they pass through a pipeline, greatly facilitating, for example, the creation of `middleware`. This enables building web servers and applications with high reusability and flexibility, from small microservices to the foundation of larger frameworks like `Phoenix`. All of this doesn't mean that `Plug` doesn't have macros or that it doesn't "do things behind the scenes," but its level of metaprogramming is much lower than in Phoenix, making it closer to pure Elixir code.

- [x] **Bandit:** [Bandit](https://hexdocs.pm/bandit/readme.html) is a fast, correct, and `pure Elixir HTTP server` designed for use with the `Plug and WebSock APIs` (about the `WebSock` API in `Bandit`, see [this](https://hexdocs.pm/websock/WebSock.html)), built on top of the [Thousand Island](https://hexdocs.pm/thousand_island/ThousandIsland.html) connection pooler (manages  concurrent connections performantly for applications built with the Elixir). It supports HTTP/1.x, HTTP/2, and WebSockets over both HTTP and HTTPS and is the default HTTP server for the `Phoenix` since version 1.7. `Bandit` prioritizes performance and correctness, outperforming its predecessor [`Cowboy`](https://github.com/ninenines/cowboy) in several benchmarks, while offering a simple, straightforward experience for Elixir developers.

- [x] **Htmx:** [Htmx](https://htmx.org/) is a `JavaScript` library that enhances HTML by adding custom attributes, allowing developers to create dynamic, interactive web applications with less `JavaScript`. It uses a hypermedia-driven approach, sending [`AJAX requests`](https://en.wikipedia.org/wiki/Ajax_(programming)) directly from HTML elements to a server and using the HTML response to update parts of the page, eliminating the need for complex client-side frameworks or extensive `JavaScript` code. `Htmx` has brought a breath of fresh air and brought back the philosophy of [`Hypermedia`](https://en.wikipedia.org/wiki/Hypermedia) to the web, something that the author of this fantastic library brilliantly explains and supports in his book [`Hypermedia Systems`](https://hypermedia.systems/), which is highly recommended reading for any web developer.

- [x] **Hyperscript:** [`Hyperscript`](https://hyperscript.org/) is a client-side scripting language that uses an English-like, natural language syntax to add interactivity to web pages with a focus on readability and simplicity. It is designed for direct use within HTML, simplifying tasks like responding to events and manipulating the DOM by embedding behavior directly into elements using an **underscore attribute** (something like this `<button _="on click toggle .red on me">`). While often used with frameworks like `Htmx`, `Hyperscript` can also function independently to provide a lightweight, declarative way to build user interfaces. Here we use it to provide greater interactivity to some elements that would require writing some JavaScript or whose implementation would be more complicated with `Htmx` alone.

- [x] **SweetAlert2:** [`SweetAlert2`](https://hyperscript.org/) is used to make an `alert and confirmation box` more attractive and easier to customize. [Integration](https://htmx.org/examples/confirm/) with `Htmx events` that trigger the execution of `SweetAlert2` confirmation boxes is very easy.

- [x] **Tailwind CSS & daisyUI:** Finally, [`Tailwind CSS`](https://v3.tailwindcss.com/) and [`daisyUI`](https://v4.daisyui.com/) are used to style HTML markup. `Tailwind CSS` is the most widely used CSS framework today, and in conjunction with the `daisyUI` CSS component library, they facilitate rapid creation of beautiful web interfaces.

- [x] **Some features of the application UI:**
  - Inline editing row
  - Live search without Ajax
  - Bulk updating multiple rows
  - Flash messages
  - Handling 404/500 errors

---

### 👨‍🚀 Getting Started:

  - <ins>Prerequisites:</ins> Obviously, you'll need to install [`Elixir`](https://elixir-lang.org/install.html) and [`Erlang/OTP`](https://www.erlang.org/) (because you'll need to use its virtual machine). I recommend doing this through [`asdf`](https://asdf-vm.com/guide/getting-started.html). This will allow you to have multiple versions of Elixir installed and easily switch between them per project or set a global version for the system. Likewise, `asdf` will also allow you to install `NodeJS` (and, similarly, manage its different versions), which is required to install the `Tailwind CSS` and `daisyUI` JavaScript packages.
    
    >***I advise you to follow the recommendations made [here](https://github.com/emarifer/elixir-desktop-todoapp?tab=readme-ov-file#prerequisites) to create a more complete Erlang/OTP installation that will give you more options when developing with Elixir/Erlang.***

  - <ins>Usage:</ins> Clone the repository and enter the project folder and install the dependencies by running this command in the terminal:

    ```
    $ mix deps.get
    ```

    Next, go to the `assets` folder and install the JavaScript dependencies you need and generate the   compiled and minified file with the CSS derived from the utility classes that appear in the `.html.eex` templates using `Tailwind CSS`:

    ```
    $ cd assets/

    $ npm i

    $ npm run build-css-prod
    ```

    You can now start the `Bandit` server with:

    ```
    $ mix run --no-halt
    ```

    Or if you want, use the Elixir shell (IEx):

    ```
    $ iex -S mix
    ```

    Now, if you visit the address `http://localhost:4000` in your browser you will be redirected to   `http://localhost:4000/todos` automatically and use the application.

    Alternatively, you can pass an environment variable to either of the above 2 commands that  specifies a different listening port:

    ```
    $ PORT=5000 mix run --no-halt
    ```

    Finally, you can compile the application for production as an `Elixir release`, which will include everything the application needs to run in a single folder: the `runtime`, the `BEAM VM`, the resulting binaries, and even the `assets`. Before doing so, however, you'll need to modify the application's configuration to adapt it to your specific requirements. You can find the documentation on this [here](https://hexdocs.pm/mix/Mix.Tasks.Release.html) and [here](https://hexdocs.pm/elixir/config-and-releases.html).

    >***<ins>Note:</ins> I've added the [`ExSync`](https://hexdocs.pm/exsync/readme.html) library (<ins>dev mode only</ins>) that enables `hot reloading` when you make code changes in your editor and save it. While editing, you'll need to have two terminals open, one running `npm run watch-css` to monitor changes to CSS in your `.html.eex` template files with `Tailwind CSS`, and the other running Elixir's `Bandit` server (`mix run --no-halt`). Of course, you'll need to reload your browser to see these changes in the UI.***

---

### 📚 Learn more

  - Official website: https://elixir-lang.org/
  - Elixir Docs: https://hexdocs.pm/elixir/introduction.html
  - Elixir School: https://elixirschool.com/
  - Elixir Forum: https://elixirforum.com/
  - Plug: https://hexdocs.pm/plug/readme.html
  - Bandit: https://hexdocs.pm/bandit/Bandit.html
  - Htmx: https://htmx.org/
  - Hyperscript: https://hyperscript.org/

---

### Happy coding 😀!!

