Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC00BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB6324901
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgFUNei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgFUNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:34:37 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A1C061794;
        Sun, 21 Jun 2020 06:34:37 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B073445378;
        Sun, 21 Jun 2020 13:34:32 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/arm
Date:   Sun, 21 Jun 2020 15:34:21 +0200
Message-Id: <20200621133421.46250-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
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
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Documentation/arm/arm.rst                     |  8 ++---
 Documentation/arm/keystone/overview.rst       |  4 +--
 Documentation/arm/microchip.rst               | 30 +++++++++----------
 Documentation/arm/sa1100/assabet.rst          |  4 +--
 Documentation/arm/samsung-s3c24xx/h1940.rst   |  6 ++--
 .../arm/samsung-s3c24xx/overview.rst          |  6 ++--
 .../arm/samsung-s3c24xx/smdk2440.rst          |  2 +-
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/arm/arm.rst b/Documentation/arm/arm.rst
index 2edc509df92a..4f8c4985191f 100644
--- a/Documentation/arm/arm.rst
+++ b/Documentation/arm/arm.rst
@@ -48,12 +48,12 @@ Bug reports etc
 ---------------
 
   Please send patches to the patch system.  For more information, see
-  http://www.arm.linux.org.uk/developer/patches/info.php Always include some
+  https://www.arm.linux.org.uk/developer/patches/info.php Always include some
   explanation as to what the patch does and why it is needed.
 
   Bug reports should be sent to linux-arm-kernel@lists.arm.linux.org.uk,
   or submitted through the web form at
-  http://www.arm.linux.org.uk/developer/
+  https://www.arm.linux.org.uk/developer/
 
   When sending bug reports, please ensure that they contain all relevant
   information, eg. the kernel messages that were printed before/during
@@ -169,7 +169,7 @@ ST506 hard drives
 
   Previous registrations may be found online.
 
-    <http://www.arm.linux.org.uk/developer/machines/>
+    <https://www.arm.linux.org.uk/developer/machines/>
 
 Kernel entry (head.S)
 ---------------------
@@ -204,7 +204,7 @@ Kernel entry (head.S)
   compile-time code selection method.  You can register a new machine via the
   web site at:
 
-    <http://www.arm.linux.org.uk/developer/machines/>
+    <https://www.arm.linux.org.uk/developer/machines/>
 
   Note: Please do not register a machine type for DT-only platforms.  If your
   platform is DT-only, you do not need a registered machine type.
diff --git a/Documentation/arm/keystone/overview.rst b/Documentation/arm/keystone/overview.rst
index cd90298c493c..3e4b2f8f5e8b 100644
--- a/Documentation/arm/keystone/overview.rst
+++ b/Documentation/arm/keystone/overview.rst
@@ -16,7 +16,7 @@ K2HK SoC and EVM
 a.k.a Keystone 2 Hawking/Kepler SoC
 TCI6636K2H & TCI6636K2K: See documentation at
 
-	http://www.ti.com/product/tci6638k2k
+	https://www.ti.com/product/tci6638k2k
 	http://www.ti.com/product/tci6638k2h
 
 EVM:
@@ -31,7 +31,7 @@ K2E  -  66AK2E05:
 
 See documentation at
 
-	http://www.ti.com/product/66AK2E05/technicaldocuments
+	https://www.ti.com/product/66AK2E05/technicaldocuments
 
 EVM:
    https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 9c013299fd3b..4786dd68d325 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -26,44 +26,44 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
 
     * ARM 926 based SoCs
       - at91sam9260
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
 
       - at91sam9xe
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
 
       - at91sam9261
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
 
       - at91sam9263
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
 
       - at91sam9rl
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
 
       - at91sam9g20
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
 
       - at91sam9g45 family
         - at91sam9g45
@@ -73,7 +73,7 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
 
       - at91sam9x5 family (aka "The 5 series")
         - at91sam9g15
@@ -84,19 +84,19 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet (can be considered as covering the whole family)
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
 
       - at91sam9n12
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
 
       - sam9x60
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579A.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579A.pdf
 
     * ARM Cortex-A5 based SoCs
       - sama5d3 family
@@ -109,7 +109,7 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet_B.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet_B.pdf
 
     * ARM Cortex-A5 + NEON based SoCs
       - sama5d4 family
@@ -121,7 +121,7 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
 
       - sama5d2 family
 
@@ -135,7 +135,7 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
 
     * ARM Cortex-M7 MCUs
       - sams70 family
@@ -173,7 +173,7 @@ the Microchip website: http://www.microchip.com.
 
           * Datasheet
 
-          http://ww1.microchip.com/downloads/en/DeviceDoc/SAM-E70-S70-V70-V71-Family-Data-Sheet-DS60001527D.pdf
+          https://ww1.microchip.com/downloads/en/DeviceDoc/SAM-E70-S70-V70-V71-Family-Data-Sheet-DS60001527D.pdf
 
 
 Linux kernel information
diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arm/sa1100/assabet.rst
index a761e128fb08..0bc5a1b4a754 100644
--- a/Documentation/arm/sa1100/assabet.rst
+++ b/Documentation/arm/sa1100/assabet.rst
@@ -6,7 +6,7 @@ Please see:
 http://developer.intel.com
 
 Also some notes from John G Dorsey <jd5q@andrew.cmu.edu>:
-http://www.cs.cmu.edu/~wearable/software/assabet.html
+https://www.cs.cmu.edu/~wearable/software/assabet.html
 
 
 Building the kernel
@@ -32,7 +32,7 @@ BLOB (http://www.lartmaker.nl/lartware/blob/)
    patches were merged into BLOB to add support for Assabet.
 
 Compaq's Bootldr + John Dorsey's patch for Assabet support
-(http://www.handhelds.org/Compaq/bootldr.html)
+(https://www.handhelds.org/Compaq/bootldr.html)
 (http://www.wearablegroup.org/software/bootldr/)
 
    Bootldr is the bootloader developed by Compaq for the iPAQ Pocket PC.
diff --git a/Documentation/arm/samsung-s3c24xx/h1940.rst b/Documentation/arm/samsung-s3c24xx/h1940.rst
index 62a562c178e3..94fa58bda793 100644
--- a/Documentation/arm/samsung-s3c24xx/h1940.rst
+++ b/Documentation/arm/samsung-s3c24xx/h1940.rst
@@ -2,7 +2,7 @@
 HP IPAQ H1940
 =============
 
-http://www.handhelds.org/projects/h1940.html
+https://www.handhelds.org/projects/h1940.html
 
 Introduction
 ------------
@@ -18,11 +18,11 @@ Support
 
   handhelds.org project page:
 
-    http://www.handhelds.org/projects/h1940.html
+    https://www.handhelds.org/projects/h1940.html
 
   handhelds.org wiki page:
 
-    http://handhelds.org/moin/moin.cgi/HpIpaqH1940
+    https://handhelds.org/moin/moin.cgi/HpIpaqH1940
 
   Herbert Pötzl pages:
 
diff --git a/Documentation/arm/samsung-s3c24xx/overview.rst b/Documentation/arm/samsung-s3c24xx/overview.rst
index e9a1dc7276b5..b4a7db77f33b 100644
--- a/Documentation/arm/samsung-s3c24xx/overview.rst
+++ b/Documentation/arm/samsung-s3c24xx/overview.rst
@@ -114,7 +114,7 @@ Machines
   Acer N30
 
     A S3C2410 based PDA from Acer.  There is a Wiki page at
-    http://handhelds.org/moin/moin.cgi/AcerN30Documentation .
+    https://handhelds.org/moin/moin.cgi/AcerN30Documentation .
 
   AML M5900
 
@@ -140,7 +140,7 @@ Adding New Machines
   Read the kernel patch submission policies as well as the
   Documentation/arm directory before submitting patches. The
   ARM kernel series is managed by Russell King, and has a patch system
-  located at http://www.arm.linux.org.uk/developer/patches/
+  located at https://www.arm.linux.org.uk/developer/patches/
   as well as mailing lists that can be found from the same site.
 
   As a courtesy, please notify <ben-linux@fluff.org> of any new
@@ -148,7 +148,7 @@ Adding New Machines
 
   Any large scale modifications, or new drivers should be discussed
   on the ARM kernel mailing list (linux-arm-kernel) before being
-  attempted. See http://www.arm.linux.org.uk/mailinglists/ for the
+  attempted. See https://www.arm.linux.org.uk/mailinglists/ for the
   mailing list information.
 
 
diff --git a/Documentation/arm/samsung-s3c24xx/smdk2440.rst b/Documentation/arm/samsung-s3c24xx/smdk2440.rst
index 524fd0b4afaf..76996b803f7c 100644
--- a/Documentation/arm/samsung-s3c24xx/smdk2440.rst
+++ b/Documentation/arm/samsung-s3c24xx/smdk2440.rst
@@ -26,7 +26,7 @@ Support
   includes linux based USB download tools.
 
   Some of the h1940 patches that can be found from the H1940 project
-  site at http://www.handhelds.org/projects/h1940.html can also be
+  site at https://www.handhelds.org/projects/h1940.html can also be
   applied to this board.
 
 
-- 
2.27.0

