void keyPressed() {
  if (!player.cMode && key == ' ' && player.position.y == floor - player.playerImg.height) {
    player.jump();
  }
  else if (player.cMode && key == ' '){
    player.jump();
  }
}
