#if 0
#include <SPI.h>
#include <PN532_SPI.h>
#include <PN532.h>
#include <NfcAdapter.h>

PN532_SPI pn532spi(SPI, 10);
NfcAdapter nfc = NfcAdapter(pn532spi);
#else

#include <Wire.h>
#include <PN532_I2C.h>
#include <PN532.h>
#include <NfcAdapter.h>
String var = "000";
PN532_I2C pn532_i2c(Wire);
NfcAdapter nfc = NfcAdapter(pn532_i2c);
#endif

void setup() {
      Serial.begin(9600);
      //Serial.println("NDEF Writer");
      nfc.begin();
}

void loop() {

   //if (Serial.available()) 
   //{ // If data is available to read,
     var = Serial.readString(); // read it and store it in val
   //}
   
    //Serial.println("\nPlace a formatted Mifare Classic NFC tag on the reader.");
    if (nfc.tagPresent()) {
        NdefMessage message = NdefMessage();
        message.addUriRecord(var);

        bool success = nfc.write(message);
        if (success) {
          Serial.println("1");     
        } else {
          Serial.println("Write failed.");
        }
    }
    delay(100);
}
