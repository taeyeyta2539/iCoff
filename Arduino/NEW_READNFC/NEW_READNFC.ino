#include <Wire.h>
#include <SPI.h>
#include <Adafruit_PN532.h>

#define PN532_SCK  (2)
#define PN532_MOSI (3)
#define PN532_SS   (4)
#define PN532_MISO (5)


#define PN532_IRQ   (2)
#define PN532_RESET (3) 

Adafruit_PN532 nfc(PN532_IRQ, PN532_RESET);

//////////////////////////////////////HX711&MLX90614 Libraly


#include "HX711.h"
#include <Wire.h>
#include <Adafruit_MLX90614.h>
Adafruit_MLX90614 mlx = Adafruit_MLX90614();
#define DOUT  5
#define CLK  4
HX711 scale(DOUT, CLK);
float calibration_factor = -380000; //  ค่าเริ่มต้น
String payloadAsString = "0,0,0-0-0";

///////////////////////////////////////////////

void setup(void) {

  Serial.begin(9600);
  scale.set_scale();
  scale.tare(); //reset weight to 0
  long zero_factor = scale.read_average(); //read begin weight
  mlx.begin();  //Temp sensor
  nfc.begin();

  uint32_t versiondata = nfc.getFirmwareVersion();


  nfc.SAMConfig();
  String nfctext;  
}


void loop(void) {
  uint8_t success;
  uint8_t uid[] = { 0, 0, 0, 0, 0, 0, 0 };  // Buffer to store the returned UID
  uint8_t uidLength;                        // Length of the UID (4 or 7 bytes depending on ISO14443A card type)
  scale.set_scale(calibration_factor); //set value of calibration factor
  success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength);
  

        
    // Display some basic information about the card
    //nfc.PrintHex(uid, uidLength);


      uint8_t keya[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };

        uint8_t data[16];
		
        success = nfc.mifareclassic_ReadDataBlock(5, data);
		
        //if (success)
        //{ 
          Serial.print(mlx.readObjectTempC());
          Serial.print(",");
          Serial.print(scale.get_units(),2); // show decimal 2 digit
          Serial.print(",");
          //Serial.println("");
          //nfctext = 
          nfc.PrintHexChar(data, 30);
          //Serial.println("");
          //delay(1);
        //}

}
