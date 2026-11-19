import loadWasm from './wasm/site.mjs';

const form = document.querySelector('form');
const output = document.querySelector('output');
form?.addEventListener('submit', event => event.preventDefault());
try {
  const app = await loadWasm();
  if (form) {
    const [a, b] = form.querySelectorAll('input');
    const run = () => { output.textContent = app.add_wasm(a.valueAsNumber, b.valueAsNumber); };
    form.addEventListener('submit', run);
    run();
  } else {
    document.title = app.agent_title();
  }
} catch (error) {
  if (output) output.textContent = 'The WebAssembly module could not load. Reload the page to try again.';
  for (const button of document.querySelectorAll('button')) button.disabled = true;
  console.error(error);
}
