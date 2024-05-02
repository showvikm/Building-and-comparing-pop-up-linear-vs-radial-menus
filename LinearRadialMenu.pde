String introduction = " You are at the main menu. \n " +
       "Press ` to go to linear menu and Tab to go to radial menu." ;
String inLinear = "Press ` to go back to main menu";
String inRadial = "Press Tab to go back to main menu";

// For linear menu 
int linearStartX = 100;       // Initial horizontal starting point
int linearStartY = 50;        // Initial vertical starting point
int linearMenuWidth = 100;    // width of the menu
int linearMenuHeight = 30;    // height of each item in the menu

// For radial menu 
int titleSize = 100;
float backgroundCircleRadius = titleSize + 300;      // Radius for the background circle
float itemsRadius = titleSize / 2;                   // Radius of where items will be placed
float divideItemsAngle;

// Initializing flags
boolean menuIsOpen = false;       // To track if the menu is open or closed
boolean itemSelected = false;     // To track if an item has been selected
boolean linearMenu = false;       //Activates linear menu
boolean radialMenu = false;       //Activates radial menu

String[] currentItems;            // Array to hold the currently displayed items
boolean[] linearItemHovered;      // Array to track hovered state of each menu item for linear menu
boolean[] radialItemHovered;      // Array to track hovered state of each menu item for radial menu

// for displaying prompt
int currentPromptIndex = 0;         // Index for the current prompt    
int[] currentPromptSet;             // Current prompt set being used from prompts arrays
String currentPrompt;               // Current prompt being displayed
String endOfPromptsMessage = "";    // Message for end of prompts

// for time tracking
long promptStartTime;               // Time when the prompt is displayed
long selectionTime;                 // Time taken for a selection
long overallTotalTime = 0;          // To track the total time for all 40 trials it does not reset like sectionTotalTime does
long sectionTotalTime = 0;          // To track the total time for the each section it resets after set of 10 trials 
int sectionCounter = 0;             // To track the number of completed sets of 10 trials

void setup() {
  size(800, 800); // Canvas size
  textAlign(CENTER, CENTER);       // Aligns the text to be in the center of the rectangles
  
  currentItems = sports1;          // sets the current array to be sports1
  
  currentPromptSet = prompts1;     //sets the current prompt order to prompt1 
  currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
  
  divideItemsAngle = TWO_PI / currentItems.length;       // Angle between items
  linearItemHovered = new boolean[currentItems.length];   // Initialization for linear hovered item
  radialItemHovered = new boolean[currentItems.length];   // Initialization for radial hovered item
}

void draw() { 
  background(255); // Canvas colour
  
    if (!linearMenu && !radialMenu){
      fill(0);
      textSize(30);
      text(introduction, width / 2, height / 2); 
    }
  
   if (linearMenu) {
       int currentY = linearStartY + linearMenuHeight;  // Sets the initial Y coordinate for drawing the first menu item
  
       // Drawing the title for linear menu 
       fill(128);            // Grey colour for the menu title background
       rect(linearStartX, linearStartY, linearMenuWidth, linearMenuHeight);
       fill(255);            // White colour for the text
       textSize(15);
       text("Sports", linearStartX + linearMenuWidth / 2, linearStartY + linearMenuHeight / 2);
    
       if (menuIsOpen) {
         for (int i = 0; i < currentItems.length; i++) {
           // Draw items with hover state
           if (linearItemHovered[i]) {
             fill(255);     // Highlight colour is white
           } 
           else {
             fill(200);     // Normal colour is light grey
           }
           
           // Draws the rectangle for menu items
           rect(linearStartX, currentY, linearMenuWidth, linearMenuHeight);
           fill(0); // Black colour for text
           text(currentItems[i], linearStartX + linearMenuWidth / 2, currentY + linearMenuHeight / 2);
           currentY += linearMenuHeight; // Moves down to start drawing the next menu item
         }
       }
       
      // Message to go back to main menu   
      fill(0);
      text(inLinear, linearStartX + linearMenuWidth / 2  , linearStartY - 20);
      
      // Display the current prompt or the end of prompts message
      fill(0); // Black color for text
      textSize(16); // Set the size of the text
      if (currentPromptIndex >= currentPromptSet.length) {     // Check if the prompt index is at the end of the prompt array
         text(endOfPromptsMessage, linearStartX + 300, linearStartY + 10);
      } 
      else {
         text("Prompt: " + currentPrompt, linearStartX + 200, linearStartY + 10);
      }
   }
   else if (radialMenu) {
      if (menuIsOpen) {                 
          // Draws the background circle slightly larger than the title circle for placing items
          fill(200);     // Light grey for the background circle
          ellipse(width / 2, height / 2, backgroundCircleRadius, backgroundCircleRadius);
          
          for (int i = 0; i < currentItems.length; i++) {
              // Highlight hovered sections
              if (radialItemHovered[i]) {
                 fill(255); // Highlight white for hovered section
                 float startAngle = divideItemsAngle * i - HALF_PI;
                 float endAngle = startAngle + divideItemsAngle;
                 arc(width / 2, height / 2, backgroundCircleRadius, backgroundCircleRadius, startAngle, endAngle);
              }
             
              // Adjust the angle for better centering within each section
              float angle = divideItemsAngle * i - HALF_PI + (divideItemsAngle / 2);
              float itemX = width / 2 + cos(angle) * itemsRadius;
              float itemY = height / 2 + sin(angle) * itemsRadius;

              // Draws the menu items 
              fill(0);
              textSize(15);
              // Adjusts the angle to align the text vertically
              drawVerticalText(currentItems[i], itemX, itemY, angle - HALF_PI); 
            
              // Draws dividing lines for visual reference
              stroke(0); // Black colour for the dividing lines
              float lineStartX = width / 2 + cos(angle - (divideItemsAngle / 2)) * (titleSize / 2);
              float lineStartY = height / 2 + sin(angle - (divideItemsAngle / 2)) * (titleSize / 2);
              float lineEndX = width / 2 + cos(angle - (divideItemsAngle / 2)) * (backgroundCircleRadius / 2);
              float lineEndY = height / 2 + sin(angle - (divideItemsAngle / 2)) * (backgroundCircleRadius / 2);
              line(lineStartX, lineStartY, lineEndX, lineEndY); 
          }
      }
      
      // Draw the title for the radial menu
      fill(128);                                              // Grey colour for the menu title background
      ellipse(width / 2, height / 2, titleSize, titleSize);   // Title circle
      fill(255);                                              // White colour for the text
      textSize(15);
      text("Sports", width / 2, height / 2);
      
      // Message to go back to main menu  
      fill(0);
      float textYPosition = (height / 2) - (backgroundCircleRadius / 2) - 20;
      text(inRadial, width / 2, textYPosition);
      
       // Display the current prompt or the end of prompts message
        fill(0); // Black color for text
        textSize(16); // Set the size of the text
        float promptYPosition = (height / 2) + (backgroundCircleRadius / 2) + 20; 
        
        if (currentPromptIndex >= currentPromptSet.length) {     // Check if the prompt index is at the end of the prompt array
           text(endOfPromptsMessage, width / 2, promptYPosition);
        } 
        else {
           text("Prompt: " + currentPrompt, width / 2, promptYPosition);
        }
   }
}

void mouseMoved() {
  if (linearMenu){
        int currentY = linearStartY + linearMenuHeight; // Sets the initial Y coordinate
        
        // Handle hover for items
        for (int i = 0; i < currentItems.length; i++) {
          linearItemHovered[i] = mouseX > linearStartX && mouseX < linearStartX + linearMenuWidth && mouseY > currentY && mouseY < currentY + linearMenuHeight;
          currentY += linearMenuHeight; // Move down to the next menu item
        }
  }
  else if (radialMenu) {
        // Calculate the X and Y distances of the mouse cursor from the center of the circle
        float mouseXFromCenter = mouseX - width / 2;
        float mouseYFromCenter = mouseY - height / 2;
        // Calculate the distance from the center of the circle to the mouse cursor position
        float mouseDistanceFromCenter = sqrt(sq(mouseXFromCenter) + sq(mouseYFromCenter));
        
        // Calculate the angle of the mouse position
        float mouseAngle = atan2(mouseYFromCenter, mouseXFromCenter); 
        
        // Normalize mouse angle to a full circle (0 to TWO_PI)
         mouseAngle = (mouseAngle + TWO_PI) % TWO_PI;
    
        // Reset hover states for all sections 
       for (int i = 0; i < radialItemHovered.length; i++) {
          radialItemHovered[i] = false;
       }
       
       if (mouseDistanceFromCenter > titleSize / 2 && mouseDistanceFromCenter < backgroundCircleRadius / 2) {
           for (int i = 0; i < currentItems.length; i++) {
              // Normalize angles for a circular comparison (0 to TWO_PI)
              float startAngle = (divideItemsAngle * i - HALF_PI + TWO_PI) % TWO_PI;
              float endAngle = (startAngle + divideItemsAngle) % TWO_PI;
        
              // Determine if mouse is within this section's angular bounds
              boolean withinAngularBounds = false;
              if (startAngle < endAngle) {        // Checks if the mouse is within the angular bounds of the current section 
                // The section does not cross the line's boundary, the mouse angle is between the start and end angles
                withinAngularBounds = mouseAngle >= startAngle && mouseAngle < endAngle;
              } 
              else {        // If the mouse angle is greater than the start angle or less than the end angle
                // The section crosses the line's boundary, the mouse angle is either before the end angle or after the start angle
                withinAngularBounds = mouseAngle >= startAngle || mouseAngle < endAngle;
              }
        
              radialItemHovered[i] = withinAngularBounds;
          }       
       }
  }
}

void mousePressed() {
  if (linearMenu) {
     // Check if the menu title is clicked
    if (mouseX > linearStartX && mouseX < linearStartX + linearMenuWidth && mouseY > linearStartY && mouseY < linearStartY + linearMenuHeight) {
      if (menuIsOpen) { // Toggle for the menu list to open or close
        menuIsOpen = false;
      } 
      else {
        menuIsOpen = true;
      }
    }
    else if (menuIsOpen) {
        // Check for selection 
        for (int i = 0; i < currentItems.length; i++) {
           if (linearItemHovered[i]) {
             promptSelection(currentItems[i]);
             itemSelected = true;
           }
            
           if (itemSelected) {
             menuIsOpen = false; // Close the menu after an item is selected
           }
        }
     } 
  }
  else if (radialMenu) {
    if (dist(mouseX, mouseY, width / 2, height / 2) < titleSize / 2) {
       if (menuIsOpen) { // Toggle for the menu list to open or close
        menuIsOpen = false;
      } 
      else {
        menuIsOpen = true;
      }
    }
    else if (menuIsOpen) {
       // Check for selection 
       for (int i = 0; i < currentItems.length; i++) {
          if (radialItemHovered[i]) {
            promptSelection(currentItems[i]);
            itemSelected = true;
          }
            
          if (itemSelected) {
            menuIsOpen = false; // Close the menu after an item is selected
          }
        }
     } 
  }
}

void keyPressed() {
  if (key == '`') {
    // Allow toggling the linear menu only if the radial menu is not active
    if (!radialMenu) {
      if (linearMenu) {
        linearMenu =  false;    // linear menu is disabled 
      }
      else {
        linearMenu = true;      // linear menu is enabled 
        
        currentPromptIndex = 0;
        promptStartTime = millis();
        currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
      }
    }
    
      // Reset the menuIsOpen status to close the menu on toggle
      menuIsOpen = false;
  } 
  else if (key == TAB) {
    // Allow toggling the radial menu only if the linear menu is not active
    if (!linearMenu) {
      if (radialMenu) {
        radialMenu =  false;     // radial menu is disabled 
      }
      else {
        radialMenu = true;       // radial menu is enabled 
        
        currentPromptIndex = 0;
        promptStartTime = millis();
        currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
      }
      
      // Reset the menuIsOpen status to close the menu on toggle
      menuIsOpen = false;
    }
  }
  
  if (linearMenu || radialMenu){
      boolean listChanged = false;
      if (key == '1') {
        currentItems = sports1; // sets the current array to be sports1
        listChanged = true;
        
        prompts1 = generateNumbers(40, 5);   // Generates 40 numbers from 0 to 4 for sports1
        currentPromptSet = prompts1;         // Sets the current prompt order to prompt1 
        currentPromptIndex = 0;
        promptStartTime = millis();
        currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
      } 
      else if (key == '2') {
        currentItems = sports2; // sets the current array to be sports2
        listChanged = true;
        
        prompts2 = generateNumbers(40, 10);   // Generates 40 numbers from 0 to 9 for sports2
        currentPromptSet = prompts2;          // Sets the current prompt order to prompt2 
        currentPromptIndex = 0;
        promptStartTime = millis();
        currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
      } 
      else if (key == '3') {
        currentItems = sports3; // sets the current array to be sports3
        listChanged = true;
        
        prompts3 = generateNumbers(40, 15);     // Generates 40 numbers from 0 to 14 for sports3
        currentPromptSet = prompts3;            // Sets the current prompt order to prompt3 
        currentPromptIndex = 0;
        promptStartTime = millis();
        currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];    //sets the starting point for prompt
      }
    
      if (listChanged) {
        // Recalculateing the angle based on the new list size
        divideItemsAngle = TWO_PI / currentItems.length;
        // Reinitializeing hover states to match the new list size
        linearItemHovered = new boolean[currentItems.length];
        radialItemHovered = new boolean[currentItems.length];
      }
  }
}

void drawVerticalText(String text, float x, float y, float angle) {
  pushMatrix();       // Saves the current transformation matrix
  
  translate(x, y);    // Translates to the position where to draw the text
  rotate(angle);      // Rotate to align with the division line
  
  // Loop through each character in the string
  for (int i = 0; i < text.length(); i++) {
    char singleItem = text.charAt(i); // Gets the characters
    // Draws the characters at the current position
    text(singleItem, 0, (i * 15) + 20);
  }
  
  popMatrix();       // Restores the original transformation matrix
}

void promptSelection(String selectedItem){
    if (selectedItem.equals(currentPrompt)) {
      selectionTime = millis() - promptStartTime;
      
      // Gets the total and section selection completation time 
      overallTotalTime += selectionTime;
      sectionTotalTime += selectionTime; 
      
      println("Type of Menu: " + typrOfMenu() + ", Number of Items in Menu: " + numberOfItems() + ", Trial Number: " + (currentPromptIndex + 1) 
                   + ", Target Name: " + currentPrompt + ", Selection Time: " + selectionTime +  " milliseconds");   
      println("Total time for this trial up to TrialNumber " + (currentPromptIndex + 1) + " is " + overallTotalTime + " milliseconds");               
      
      // updating prompts        
      promptStartTime = millis();  // Record the time when the prompt is updated  
      currentPromptIndex++;
      
      if (currentPromptIndex % 10 == 0) {     // Every 10 trials get the average completion time
         float averageSectionTime = sectionTotalTime / 10.0;     // Calculates average time for this set of 10 trials
         println("Average time for trials " + (sectionCounter * 10 + 1) + " to " + (sectionCounter * 10 + 10) + " is " + averageSectionTime + " milliseconds");
         sectionTotalTime = 0;   // Reset total time for the next set of 10 trials
         sectionCounter++;      // Increment the set counter
     }
      
      if (currentPromptIndex >= currentPromptSet.length) {
          endOfPromptsMessage = "End of prompts from this prompt set";   
          println("Average time for all trials in this prompt set is " + (float)(overallTotalTime / currentPromptSet.length) + " milliseconds");   
      } 
      else {
          if (currentPromptSet == prompts1) {
              currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];
          } 
          else if (currentPromptSet == prompts2) {
              currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];
          } 
          else if (currentPromptSet == prompts3) {
              currentPrompt = currentItems[currentPromptSet[currentPromptIndex]];
          } 
      }
   }
}

String typrOfMenu(){
  if (linearMenu){
    return "Linear";
  }
  else if (radialMenu){
    return "Radial";
  }
  return "";     // Default case
}

int numberOfItems() {
  if (currentPromptSet == prompts1){ 
    return currentItems.length;
  }
  else if (currentPromptSet == prompts2) {
    return currentItems.length;
  }
  else if (currentPromptSet == prompts3){ 
    return currentItems.length;
  }
  return 0;     // Default case
}
