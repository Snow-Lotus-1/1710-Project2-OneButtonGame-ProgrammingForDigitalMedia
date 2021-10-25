void keyPressed() {
  //the conditions set here make it so that the player needs to be on the floor to jump, otherwise it can't
  if (!player.cMode && key == ' ' && player.position.y == floor - player.playerImg.height) {
    player.jump();
  }
  //when cMode is on, the restriction for floor is removed so you can jump midair during cMode
  else if (player.cMode && key == ' '){
    player.jump();
  }
}
