///////////////////////////////////////NFC libraly
#include <Wire.h>
#include <PN532_I2C.h>
#include <PN532.h>
#include <NfcAdapter.h>


PN532_I2C pn532_i2c(Wire);
NfcAdapter nfc = NfcAdapter(pn532_i2c);


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

void setup() {

  Serial.begin(9600);
  scale.set_scale();
  scale.tare(); //reset weight to 0

  long zero_factor = scale.read_average(); //read begin weight
  mlx.begin();  //Temp sensor
  nfc.begin();  //NFC

}

///////////////////////////////////////////////


void loop() {
String payloadAsString2;
  

  scale.set_scale(calibration_factor); //set value of calibration factor
  

//////////////////////////////////////////NFC
if (nfc.tagPresent())
  {
    NfcTag tag = nfc.read();
    

    if (tag.hasNdefMessage())
    {

      NdefMessage message = tag.getNdefMessage();

      int recordCount = message.getRecordCount();
      for (int i = 0; i < recordCount; i++)
      {
        NdefRecord record = message.getRecord(i);
        
        int payloadLength = record.getPayloadLength();
        byte payload[payloadLength];
        record.getPayload(payload);

        String payloadAsString = "";
        for (int c = 0; c < payloadLength; c++) {
          payloadAsString += (char)payload[c];
        }
        





 
  
        Serial.print(mlx.readObjectTempC());
        Serial.print(",");
        Serial.print(scale.get_units(),2); // show decimal 2 digit
        Serial.print(",");
        Serial.println(payloadAsString); 
        delay(500); //Delay 0.5 Second
            /*if(payloadAsString2 != payloadAsString){
            payloadAsString2 = payloadAsString;
            }
            else{payloadAsString2 = "0-0-0" ;}*/
      }
    }
  }
  else{Serial.println(payloadAsString);}


    
  
/////////////////////////////////////////////
  
   
 
}
