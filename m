Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E91C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521F420B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGSQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:19:31 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7BAC0619D2;
        Sun, 19 Jul 2020 09:19:30 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 42349BC062;
        Sun, 19 Jul 2020 16:19:27 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     johan@kernel.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] USB: serial: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 18:19:20 +0200
Message-Id: <20200719161920.60087-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
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


 Documentation/usb/usb-serial.rst  |  2 +-
 drivers/usb/serial/cyberjack.c    |  2 +-
 drivers/usb/serial/ftdi_sio.h     |  4 ++--
 drivers/usb/serial/ftdi_sio_ids.h | 34 +++++++++++++++----------------
 drivers/usb/serial/kobil_sct.c    |  2 +-
 drivers/usb/serial/metro-usb.c    |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
index 8fa7dbd3da9a..0a2071953691 100644
--- a/Documentation/usb/usb-serial.rst
+++ b/Documentation/usb/usb-serial.rst
@@ -202,7 +202,7 @@ Keyspan USA-series Serial Adapters
 
   More information is available at:
 
-        http://www.carnationsoftware.com/carnation/Keyspan.html
+        https://www.carnationsoftware.com/carnation/Keyspan.html
 
   For any questions or problems with this driver, please contact Hugh
   Blemings at hugh@misc.nu
diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index 821970609695..ec9dd7925a51 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -20,7 +20,7 @@
  *  Please note that later models of the cyberjack reader family are
  *  supported by a libusb-based userspace device driver.
  *
- *  Homepage: http://www.reiner-sct.de/support/treiber_cyberjack.php#linux
+ *  Homepage: https://www.reiner-sct.de/support/treiber_cyberjack.php#linux
  */
 
 
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index a79a1325b4d9..818d4c7de661 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -14,7 +14,7 @@
  * The device is based on the FTDI FT8U100AX chip. It has a DB25 on one side,
  * USB on the other.
  *
- * Thanx to FTDI (http://www.ftdichip.com) for so kindly providing details
+ * Thanx to FTDI (https://www.ftdichip.com) for so kindly providing details
  * of the protocol required to talk to the device and ongoing assistence
  * during development.
  *
@@ -452,7 +452,7 @@ enum ftdi_sio_baudrate {
  * FTDI_SIO_READ_EEPROM
  *
  * EEPROM format found in FTDI AN_201, "FT-X MTP memory Configuration",
- * http://www.ftdichip.com/Support/Documents/AppNotes/AN_201_FT-X%20MTP%20Memory%20Configuration.pdf
+ * https://www.ftdichip.com/Support/Documents/AppNotes/AN_201_FT-X%20MTP%20Memory%20Configuration.pdf
  */
 #define FTDI_SIO_READ_EEPROM_REQUEST_TYPE 0xc0
 #define FTDI_SIO_READ_EEPROM_REQUEST FTDI_SIO_READ_EEPROM
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index e8373528264c..a5bf2b974813 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -60,14 +60,14 @@
 /*
  * Texas Instruments XDS100v2 JTAG / BeagleBone A3
  * http://processors.wiki.ti.com/index.php/XDS100
- * http://beagleboard.org/bone
+ * https://beagleboard.org/bone
  */
 #define TI_XDS100V2_PID		0xa6d0
 
 #define FTDI_NXTCAM_PID		0xABB8 /* NXTCam for Mindstorms NXT */
 #define FTDI_EV3CON_PID		0xABB9 /* Mindstorms EV3 Console Adapter */
 
-/* US Interface Navigator (http://www.usinterface.com/) */
+/* US Interface Navigator (https://www.usinterface.com/) */
 #define FTDI_USINT_CAT_PID	0xb810	/* Navigator CAT and 2nd PTT lines */
 #define FTDI_USINT_WKEY_PID	0xb811	/* Navigator WKEY and FSK lines */
 #define FTDI_USINT_RS232_PID	0xb812	/* Navigator RS232 and CONFIG lines */
@@ -92,11 +92,11 @@
 #define FTDI_OPENDCC_GBM_PID	0xBFDC
 #define FTDI_OPENDCC_GBM_BOOST_PID	0xBFDD
 
-/* NZR SEM 16+ USB (http://www.nzr.de) */
+/* NZR SEM 16+ USB (https://www.nzr.de) */
 #define FTDI_NZR_SEM_USB_PID	0xC1E0	/* NZR SEM-LOG16+ */
 
 /*
- * RR-CirKits LocoBuffer USB (http://www.rr-cirkits.com)
+ * RR-CirKits LocoBuffer USB (https://www.rr-cirkits.com)
  */
 #define FTDI_RRCIRKITS_LOCOBUFFER_PID	0xc7d0	/* LocoBuffer USB */
 
@@ -122,7 +122,7 @@
 
 #define FTDI_DISTORTEC_JTAG_LOCK_PICK_PID	0xCFF8
 
-/* SCS HF Radio Modems PID's (http://www.scs-ptc.com) */
+/* SCS HF Radio Modems PID's (https://www.scs-ptc.com) */
 /* the VID is the standard ftdi vid (FTDI_VID) */
 #define FTDI_SCS_DEVICE_0_PID 0xD010    /* SCS PTC-IIusb */
 #define FTDI_SCS_DEVICE_1_PID 0xD011    /* SCS Tracker / DSP TNC */
@@ -138,7 +138,7 @@
 #define FTDI_IPLUS2_PID 0xD071 /* Product Id */
 
 /*
- * Gamma Scout (http://gamma-scout.com/). Submitted by rsc@runtux.com.
+ * Gamma Scout (https://gamma-scout.com/). Submitted by rsc@runtux.com.
  */
 #define FTDI_GAMMA_SCOUT_PID		0xD678	/* Gamma Scout online */
 
@@ -153,7 +153,7 @@
 #define FTDI_VARDAAN_PID	0xF070
 
 /*
- * Xsens Technologies BV products (http://www.xsens.com).
+ * Xsens Technologies BV products (https://www.xsens.com).
  */
 #define XSENS_VID		0x2639
 #define XSENS_AWINDA_STATION_PID 0x0101
@@ -360,7 +360,7 @@
 #define FTDI_MAXSTREAM_PID	0xEE18	/* Xbee PKG-U Module */
 
 /*
- * microHAM product IDs (http://www.microham.com).
+ * microHAM product IDs (https://www.microham.com).
  * Submitted by Justin Burket (KL1RL) <zorton@jtan.com>
  * and Mike Studer (K6EEP) <k6eep@hamsoftware.org>.
  * Ian Abbott <abbotti@mev.co.uk> added a few more from the driver INF file.
@@ -576,7 +576,7 @@
 
 /*
  * Synapse Wireless product ids (FTDI_VID)
- * http://www.synapse-wireless.com
+ * https://www.synapse-wireless.com
  */
 #define FTDI_SYNAPSE_SS200_PID 0x9090 /* SS200 - SNAP Stick 200 */
 
@@ -630,7 +630,7 @@
  * applications.  The VID/PID has also been used in firmware
  * emulating FTDI serial chips by:
  * Hornby Elite - Digital Command Control Console
- * http://www.hornby.com/hornby-dcc/controllers/
+ * https://www.hornby.com/hornby-dcc/controllers/
  */
 #define MICROCHIP_VID		0x04D8
 #define MICROCHIP_USB_BOARD_PID	0x000A /* CDC RS-232 Emulation Demo */
@@ -746,7 +746,7 @@
 #define ICOM_ID_RP2KVR_PID	0x0013 /* ID-RP2000V Receive config port */
 
 /*
- * GN Otometrics (http://www.otometrics.com)
+ * GN Otometrics (https://www.otometrics.com)
  * Submitted by Ville Sundberg.
  */
 #define GN_OTOMETRICS_VID	0x0c33	/* Vendor ID */
@@ -969,7 +969,7 @@
 
 /*
  * Physik Instrumente
- * http://www.physikinstrumente.com/en/products/
+ * https://www.physikinstrumente.com/en/products/
  */
 /* These two devices use the VID of FTDI */
 #define PI_C865_PID	0xe0a0  /* PI C-865 Piezomotor Controller */
@@ -1399,7 +1399,7 @@
 #define MJSG_HD_RADIO_PID	0x937C
 
 /*
- * D.O.Tec products (http://www.directout.eu)
+ * D.O.Tec products (https://www.directout.eu)
  */
 #define FTDI_DOTEC_PID 0x9868
 
@@ -1419,7 +1419,7 @@
 
 
 /*
- * Accesio USB Data Acquisition products (http://www.accesio.com/)
+ * Accesio USB Data Acquisition products (https://www.accesio.com/)
  */
 #define ACCESIO_COM4SM_PID 	0xD578
 
@@ -1435,7 +1435,7 @@
 #define MILKYMISTONE_JTAGSERIAL_PID	0x0713
 
 /*
- * CTI GmbH RS485 Converter http://www.cti-lean.com/
+ * CTI GmbH RS485 Converter https://www.cti-lean.com/
  */
 /* USB-485-Mini*/
 #define FTDI_CTI_MINI_PID	0xF608
@@ -1443,7 +1443,7 @@
 #define FTDI_CTI_NANO_PID	0xF60B
 
 /*
- * ZeitControl cardsystems GmbH rfid-readers http://zeitcontrol.de
+ * ZeitControl cardsystems GmbH rfid-readers https://zeitcontrol.de
  */
 /* TagTracer MIFARE*/
 #define FTDI_ZEITCONTROL_TAGTRACE_MIFARE_PID	0xF7C0
@@ -1523,7 +1523,7 @@
 #define BRAINBOXES_US_160_8_PID		0x9008 /* US-160 16xRS232 1Mbaud Port 15 and 16 */
 
 /*
- * ekey biometric systems GmbH (http://ekey.net/)
+ * ekey biometric systems GmbH (https://ekey.net/)
  */
 #define FTDI_EKEY_CONV_USB_PID		0xCB08	/* Converter USB */
 
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index e9882ba20933..c1b24bdd30bc 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -33,7 +33,7 @@
 #include <linux/ioctl.h>
 #include "kobil_sct.h"
 
-#define DRIVER_AUTHOR "KOBIL Systems GmbH - http://www.kobil.com"
+#define DRIVER_AUTHOR "KOBIL Systems GmbH - https://www.kobil.com"
 #define DRIVER_DESC "KOBIL USB Smart Card Terminal Driver (experimental)"
 
 #define KOBIL_VENDOR_ID			0x0D46
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index e63cea02cfd8..afd72c09c7fe 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -4,7 +4,7 @@
   distributed with Linux.
 
   Copyright:	2007 Metrologic Instruments. All rights reserved.
-  Copyright:	2011 Azimut Ltd. <http://azimutrzn.ru/>
+  Copyright:	2011 Azimut Ltd. <https://azimutrzn.ru/>
 */
 
 #include <linux/kernel.h>
-- 
2.27.0

