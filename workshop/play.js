const play = document.querySelector('#workshop-play');
const player = document.querySelector('#workshop-player');

play.addEventListener('click', event => {
  if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;

  event.preventDefault();
  let frame = player.querySelector('iframe');
  if (!frame) {
    frame = document.createElement('iframe');
    const game = new URL(play.href);
    game.searchParams.set('embed', '1');
    frame.src = game.href;
    frame.title = 'Play Neural Workshop Enhanced';
    frame.allow = 'fullscreen; autoplay';
    player.append(frame);
    player.hidden = false;
  }
  player.scrollIntoView({ block: 'start' });
  frame.focus();
});
