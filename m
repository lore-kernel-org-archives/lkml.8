Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9380C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA45208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGSRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:55:25 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:41950 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgGSRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:55:24 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 369AFBC078;
        Sun, 19 Jul 2020 17:55:19 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] hwmon: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 19:55:12 +0200
Message-Id: <20200719175512.60745-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/hwmon/adc128d818.rst |  2 +-
 Documentation/hwmon/adm1026.rst    |  2 +-
 Documentation/hwmon/adm1031.rst    |  4 ++--
 Documentation/hwmon/adt7410.rst    |  8 ++++----
 Documentation/hwmon/emc1403.rst    |  6 +++---
 Documentation/hwmon/ina3221.rst    |  2 +-
 Documentation/hwmon/lm63.rst       |  2 +-
 Documentation/hwmon/lm70.rst       |  6 +++---
 Documentation/hwmon/lm73.rst       |  2 +-
 Documentation/hwmon/lm75.rst       | 26 +++++++++++++-------------
 Documentation/hwmon/lm85.rst       |  8 ++++----
 Documentation/hwmon/lm87.rst       |  2 +-
 Documentation/hwmon/lm95245.rst    |  4 ++--
 Documentation/hwmon/max31790.rst   |  2 +-
 Documentation/hwmon/sht21.rst      |  4 ++--
 Documentation/hwmon/shtc1.rst      |  6 +++---
 Documentation/hwmon/thmc50.rst     |  2 +-
 Documentation/hwmon/tmp103.rst     |  2 +-
 Documentation/hwmon/tmp108.rst     |  2 +-
 Documentation/hwmon/tmp421.rst     |  4 ++--
 Documentation/hwmon/tps53679.rst   |  8 ++++----
 Documentation/hwmon/w83781d.rst    |  6 +++---
 Documentation/hwmon/w83l785ts.rst  |  2 +-
 Documentation/hwmon/w83l786ng.rst  |  2 +-
 drivers/hwmon/adm1026.c            |  2 +-
 drivers/hwmon/hwmon-vid.c          | 14 +++++++-------
 drivers/hwmon/ina3221.c            |  2 +-
 drivers/hwmon/lm87.c               |  2 +-
 drivers/hwmon/powr1220.c           |  2 +-
 drivers/hwmon/sht21.c              |  2 +-
 drivers/hwmon/w83l785ts.c          |  2 +-
 31 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/Documentation/hwmon/adc128d818.rst b/Documentation/hwmon/adc128d818.rst
index 6753468932ab..d2488023430f 100644
--- a/Documentation/hwmon/adc128d818.rst
+++ b/Documentation/hwmon/adc128d818.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f
 
-    Datasheet: Publicly available at the TI website http://www.ti.com/
+    Datasheet: Publicly available at the TI website https://www.ti.com/
 
 Author: Guenter Roeck
 
diff --git a/Documentation/hwmon/adm1026.rst b/Documentation/hwmon/adm1026.rst
index 35d63e6498a3..66f996fa3031 100644
--- a/Documentation/hwmon/adm1026.rst
+++ b/Documentation/hwmon/adm1026.rst
@@ -10,7 +10,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADM1026
 
 Authors:
 	- Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computing
diff --git a/Documentation/hwmon/adm1031.rst b/Documentation/hwmon/adm1031.rst
index a677c3ab5574..be74ec1f3e73 100644
--- a/Documentation/hwmon/adm1031.rst
+++ b/Documentation/hwmon/adm1031.rst
@@ -10,7 +10,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
+	       https://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
 
   * Analog Devices ADM1031
 
@@ -20,7 +20,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
+	       https://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
 
 Authors:
 	- Alexandre d'Alton <alex@alexdalton.org>
diff --git a/Documentation/hwmon/adt7410.rst b/Documentation/hwmon/adt7410.rst
index 24caaa83c8ec..3f5a43561bf1 100644
--- a/Documentation/hwmon/adt7410.rst
+++ b/Documentation/hwmon/adt7410.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/static/imported-files/data_sheets/ADT7410.pdf
+	       https://www.analog.com/static/imported-files/data_sheets/ADT7410.pdf
   * Analog Devices ADT7420
 
     Prefix: 'adt7420'
@@ -20,7 +20,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/static/imported-files/data_sheets/ADT7420.pdf
+	       https://www.analog.com/static/imported-files/data_sheets/ADT7420.pdf
 
   * Analog Devices ADT7310
 
@@ -30,7 +30,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/static/imported-files/data_sheets/ADT7310.pdf
+	       https://www.analog.com/static/imported-files/data_sheets/ADT7310.pdf
 
   * Analog Devices ADT7320
 
@@ -40,7 +40,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/static/imported-files/data_sheets/ADT7320.pdf
+	       https://www.analog.com/static/imported-files/data_sheets/ADT7320.pdf
 
 Author: Hartmut Knaack <knaack.h@gmx.de>
 
diff --git a/Documentation/hwmon/emc1403.rst b/Documentation/hwmon/emc1403.rst
index 3a4913b63ef3..0de9616b24ed 100644
--- a/Documentation/hwmon/emc1403.rst
+++ b/Documentation/hwmon/emc1403.rst
@@ -12,7 +12,7 @@ Supported chips:
     Datasheets:
 
 	- http://ww1.microchip.com/downloads/en/DeviceDoc/1412.pdf
-	- http://ww1.microchip.com/downloads/en/DeviceDoc/1402.pdf
+	- https://ww1.microchip.com/downloads/en/DeviceDoc/1402.pdf
 
   * SMSC / Microchip EMC1403, EMC1404, EMC1413, EMC1414
 
@@ -33,7 +33,7 @@ Supported chips:
 
     Datasheet:
 
-	- http://ww1.microchip.com/downloads/en/DeviceDoc/1422.pdf
+	- https://ww1.microchip.com/downloads/en/DeviceDoc/1422.pdf
 
   * SMSC / Microchip EMC1423, EMC1424
 
@@ -43,7 +43,7 @@ Supported chips:
 
     Datasheet:
 
-	- http://ww1.microchip.com/downloads/en/DeviceDoc/1423_1424.pdf
+	- https://ww1.microchip.com/downloads/en/DeviceDoc/1423_1424.pdf
 
 Author:
     Kalhan Trisal <kalhan.trisal@intel.com
diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
index 297f7323b441..8c12c54d2c24 100644
--- a/Documentation/hwmon/ina3221.rst
+++ b/Documentation/hwmon/ina3221.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
 Author: Andrew F. Davis <afd@ti.com>
 
diff --git a/Documentation/hwmon/lm63.rst b/Documentation/hwmon/lm63.rst
index f478132b0408..9e27367d7405 100644
--- a/Documentation/hwmon/lm63.rst
+++ b/Documentation/hwmon/lm63.rst
@@ -39,7 +39,7 @@ Author: Jean Delvare <jdelvare@suse.de>
 Thanks go to Tyan and especially Alex Buckingham for setting up a remote
 access to their S4882 test platform for this driver.
 
-  http://www.tyan.com/
+  https://www.tyan.com/
 
 Description
 -----------
diff --git a/Documentation/hwmon/lm70.rst b/Documentation/hwmon/lm70.rst
index f259bc1fcd91..6ddc5b67ccb5 100644
--- a/Documentation/hwmon/lm70.rst
+++ b/Documentation/hwmon/lm70.rst
@@ -13,15 +13,15 @@ Supported chips:
 
   * Texas Instruments TMP122/TMP124
 
-    Information: http://www.ti.com/product/tmp122
+    Information: https://www.ti.com/product/tmp122
 
   * National Semiconductor LM71
 
-    Datasheet: http://www.ti.com/product/LM71
+    Datasheet: https://www.ti.com/product/LM71
 
   * National Semiconductor LM74
 
-    Datasheet: http://www.ti.com/product/LM74
+    Datasheet: https://www.ti.com/product/LM74
 
 
 Author:
diff --git a/Documentation/hwmon/lm73.rst b/Documentation/hwmon/lm73.rst
index 1d6a46844e85..74e909be6ef7 100644
--- a/Documentation/hwmon/lm73.rst
+++ b/Documentation/hwmon/lm73.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/product/lm73
+	       https://www.ti.com/product/lm73
 
 
 Author: Guillaume Ligneul <guillaume.ligneul@gmail.com>
diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index e749f827c002..81257d5fc48f 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -31,7 +31,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Maxim website
 
-	       http://www.maximintegrated.com/
+	       https://www.maximintegrated.com/
 
   * Maxim MAX6625, MAX6626, MAX31725, MAX31726
 
@@ -71,7 +71,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Analog Devices website
 
-	       http://www.analog.com/adt75
+	       https://www.analog.com/adt75
 
   * ST Microelectronics STDS75
 
@@ -101,23 +101,23 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/product/tmp100
+	       https://www.ti.com/product/tmp100
 
-	       http://www.ti.com/product/tmp101
+	       https://www.ti.com/product/tmp101
 
-	       http://www.ti.com/product/tmp105
+	       https://www.ti.com/product/tmp105
 
-	       http://www.ti.com/product/tmp112
+	       https://www.ti.com/product/tmp112
 
-	       http://www.ti.com/product/tmp75
+	       https://www.ti.com/product/tmp75
 
-	       http://www.ti.com/product/tmp75b
+	       https://www.ti.com/product/tmp75b
 
-	       http://www.ti.com/product/tmp75c
+	       https://www.ti.com/product/tmp75c
 
-	       http://www.ti.com/product/tmp175
+	       https://www.ti.com/product/tmp175
 
-	       http://www.ti.com/product/tmp275
+	       https://www.ti.com/product/tmp275
 
   * NXP LM75B, PCT2075
 
@@ -127,9 +127,9 @@ Supported chips:
 
     Datasheet: Publicly available at the NXP website
 
-	       http://www.nxp.com/documents/data_sheet/LM75B.pdf
+	       https://www.nxp.com/documents/data_sheet/LM75B.pdf
 
-               http://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
+               https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
 
 Author: Frodo Looijaard <frodol@dds.nl>
 
diff --git a/Documentation/hwmon/lm85.rst b/Documentation/hwmon/lm85.rst
index faa92f54431c..55e1d9cdaaae 100644
--- a/Documentation/hwmon/lm85.rst
+++ b/Documentation/hwmon/lm85.rst
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
 
-    Datasheet: http://www.ti.com/lit/ds/symlink/lm96000.pdf
+    Datasheet: https://www.ti.com/lit/ds/symlink/lm96000.pdf
 
   * Analog Devices ADM1027
 
@@ -25,7 +25,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
 
-    Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADM1027
+    Datasheet: https://www.onsemi.com/PowerSolutions/product.do?id=ADM1027
 
   * Analog Devices ADT7463
 
@@ -33,7 +33,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
 
-    Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7463
+    Datasheet: https://www.onsemi.com/PowerSolutions/product.do?id=ADT7463
 
   * Analog Devices ADT7468
 
@@ -41,7 +41,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
 
-    Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7468
+    Datasheet: https://www.onsemi.com/PowerSolutions/product.do?id=ADT7468
 
   * SMSC EMC6D100, SMSC EMC6D101
 
diff --git a/Documentation/hwmon/lm87.rst b/Documentation/hwmon/lm87.rst
index 72fcb577ef2a..b8fec5689648 100644
--- a/Documentation/hwmon/lm87.rst
+++ b/Documentation/hwmon/lm87.rst
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c - 0x2e
 
-    Datasheet: http://www.analog.com/en/prod/0,2877,ADM1024,00.html
+    Datasheet: https://www.analog.com/en/prod/0,2877,ADM1024,00.html
 
 
 Authors:
diff --git a/Documentation/hwmon/lm95245.rst b/Documentation/hwmon/lm95245.rst
index 566d1dc8c5a6..836d9a3f53f9 100644
--- a/Documentation/hwmon/lm95245.rst
+++ b/Documentation/hwmon/lm95245.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Datasheet: Publicly available at the TI website
 
-	       http://www.ti.com/lit/ds/symlink/lm95235.pdf
+	       https://www.ti.com/lit/ds/symlink/lm95235.pdf
 
   * TI / National Semiconductor LM95245
 
@@ -17,7 +17,7 @@ Supported chips:
 
     Datasheet: Publicly available at the TI website
 
-	       http://www.ti.com/lit/ds/symlink/lm95245.pdf
+	       https://www.ti.com/lit/ds/symlink/lm95245.pdf
 
 Author: Alexander Stein <alexander.stein@systec-electronic.com>
 
diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 84c62a12ef3a..f301385d8cef 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://pdfserv.maximintegrated.com/en/ds/MAX31790.pdf
+    Datasheet: https://pdfserv.maximintegrated.com/en/ds/MAX31790.pdf
 
 Author: Il Han <corone.il.han@gmail.com>
 
diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
index f1f5da030108..1bccc8e8aac8 100644
--- a/Documentation/hwmon/sht21.rst
+++ b/Documentation/hwmon/sht21.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Sensirion website
 
-    http://www.sensirion.com/file/datasheet_sht21
+    https://www.sensirion.com/file/datasheet_sht21
 
 
 
@@ -23,7 +23,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Sensirion website
 
-    http://www.sensirion.com/file/datasheet_sht25
+    https://www.sensirion.com/file/datasheet_sht25
 
 
 
diff --git a/Documentation/hwmon/shtc1.rst b/Documentation/hwmon/shtc1.rst
index 08380f21ab6a..f38c4c9d2f74 100644
--- a/Documentation/hwmon/shtc1.rst
+++ b/Documentation/hwmon/shtc1.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://www.sensirion.com/file/datasheet_shtc1
+    Datasheet: https://www.sensirion.com/file/datasheet_shtc1
 
 
 
@@ -19,7 +19,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://www.sensirion.com/file/datasheet_shtw1
+    Datasheet: https://www.sensirion.com/file/datasheet_shtw1
 
 
 
@@ -29,7 +29,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://www.sensirion.com/file/datasheet_shtc3
+    Datasheet: https://www.sensirion.com/file/datasheet_shtc3
 
 
 
diff --git a/Documentation/hwmon/thmc50.rst b/Documentation/hwmon/thmc50.rst
index cfff3885287d..090f040294a3 100644
--- a/Documentation/hwmon/thmc50.rst
+++ b/Documentation/hwmon/thmc50.rst
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c - 0x2e
 
-    Datasheet: http://www.ti.com/
+    Datasheet: https://www.ti.com/
 
 
 Author: Krzysztof Helt <krzysztof.h1@wp.pl>
diff --git a/Documentation/hwmon/tmp103.rst b/Documentation/hwmon/tmp103.rst
index 205de6148fcb..e195a7d14309 100644
--- a/Documentation/hwmon/tmp103.rst
+++ b/Documentation/hwmon/tmp103.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Product info and datasheet: http://www.ti.com/product/tmp103
+    Product info and datasheet: https://www.ti.com/product/tmp103
 
 Author:
 
diff --git a/Documentation/hwmon/tmp108.rst b/Documentation/hwmon/tmp108.rst
index 5f4266a16cb2..6df7cf1b42f4 100644
--- a/Documentation/hwmon/tmp108.rst
+++ b/Documentation/hwmon/tmp108.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://www.ti.com/product/tmp108
+    Datasheet: https://www.ti.com/product/tmp108
 
 Author:
 
diff --git a/Documentation/hwmon/tmp421.rst b/Documentation/hwmon/tmp421.rst
index 1ba926a3605c..ddcd5159c75d 100644
--- a/Documentation/hwmon/tmp421.rst
+++ b/Documentation/hwmon/tmp421.rst
@@ -33,7 +33,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
 
-    Datasheet: http://www.ti.com/product/tmp441
+    Datasheet: https://www.ti.com/product/tmp441
 
   * Texas Instruments TMP442
 
@@ -41,7 +41,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x4c and 0x4d
 
-    Datasheet: http://www.ti.com/product/tmp442
+    Datasheet: https://www.ti.com/product/tmp442
 
 Authors:
 
diff --git a/Documentation/hwmon/tps53679.rst b/Documentation/hwmon/tps53679.rst
index be94cab78967..c7c589e49789 100644
--- a/Documentation/hwmon/tps53679.rst
+++ b/Documentation/hwmon/tps53679.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.ti.com/lit/gpn/tps53647
+    Datasheet: https://www.ti.com/lit/gpn/tps53647
 
   * Texas Instruments TPS53667
 
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.ti.com/lit/gpn/TPS53667
+    Datasheet: https://www.ti.com/lit/gpn/TPS53667
 
   * Texas Instruments TPS53679
 
@@ -25,7 +25,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.ti.com/lit/gpn/TPS53679 (short version)
+    Datasheet: https://www.ti.com/lit/gpn/TPS53679 (short version)
 
   * Texas Instruments TPS53681
 
@@ -33,7 +33,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.ti.com/lit/gpn/TPS53681
+    Datasheet: https://www.ti.com/lit/gpn/TPS53681
 
   * Texas Instruments TPS53688
 
diff --git a/Documentation/hwmon/w83781d.rst b/Documentation/hwmon/w83781d.rst
index f36d33dfb704..514250810b00 100644
--- a/Documentation/hwmon/w83781d.rst
+++ b/Documentation/hwmon/w83781d.rst
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
 
-    Datasheet: http://www.winbond.com
+    Datasheet: https://www.winbond.com
 
   * Winbond W83783S
 
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index e0f630c64152..af77096724fd 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -7,7 +7,7 @@
  *
  * Chip details at:
  *
- * <http://www.onsemi.com/PowerSolutions/product.do?id=ADM1026>
+ * <https://www.onsemi.com/PowerSolutions/product.do?id=ADM1026>
  */
 
 #include <linux/module.h>
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 8ae68dfa75b2..72f53e0ebf01 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -49,15 +49,15 @@
  * The 13 specification corresponds to the Intel Pentium M series. There
  * doesn't seem to be any named specification for these. The conversion
  * tables are detailed directly in the various Pentium M datasheets:
- * http://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
+ * https://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
  *
  * The 14 specification corresponds to Intel Core series. There
  * doesn't seem to be any named specification for these. The conversion
  * tables are detailed directly in the various Pentium Core datasheets:
- * http://www.intel.com/design/mobile/datashts/309221.htm
+ * https://www.intel.com/design/mobile/datashts/309221.htm
  *
  * The 110 (VRM 11) specification corresponds to Intel Conroe based series.
- * http://www.intel.com/design/processor/applnots/313214.htm
+ * https://www.intel.com/design/processor/applnots/313214.htm
  */
 
 /*
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index f335d0cb0c77..7fc5b065ad8b 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -2,7 +2,7 @@
 /*
  * INA3221 Triple Current/Voltage Monitor
  *
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index ad501ac4a594..c96c4d807e38 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -40,7 +40,7 @@
  * This driver also supports the ADM1024, a sensor chip made by Analog
  * Devices. That chip is fully compatible with the LM87. Complete
  * datasheet can be obtained from Analog's website at:
- *   http://www.analog.com/en/prod/0,2877,ADM1024,00.html
+ *   https://www.analog.com/en/prod/0,2877,ADM1024,00.html
  */
 
 #include <linux/module.h>
diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
index 65997421ee3c..a5d1a890d0be 100644
--- a/drivers/hwmon/powr1220.c
+++ b/drivers/hwmon/powr1220.c
@@ -4,7 +4,7 @@
  * and monitor. Users can read all ADC inputs along with their labels
  * using the sysfs nodes.
  *
- * Copyright (c) 2014 Echo360 http://www.echo360.com
+ * Copyright (c) 2014 Echo360 https://www.echo360.com
  * Scott Kanowitz <skanowitz@echo360.com> <scott.kanowitz@gmail.com>
  */
 
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index bc70c8332d9a..8ea5534455f2 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2010 Urs Fleisch <urs.fleisch@sensirion.com>
  *
- * Data sheet available at http://www.sensirion.com/file/datasheet_sht21
+ * Data sheet available at https://www.sensirion.com/file/datasheet_sht21
  */
 
 #include <linux/module.h>
-- 
2.27.0

