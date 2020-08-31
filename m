Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10404C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65CF21655
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgHaRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:11:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47979 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHaRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:48 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 77EC46000B;
        Mon, 31 Aug 2020 17:11:43 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/5] ARM: dts: at91: add unit-address to memory node
Date:   Mon, 31 Aug 2020 19:11:28 +0200
Message-Id: <20200831171129.3886857-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory node requires a unit-address, add it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/animeo_ip.dts               | 2 +-
 arch/arm/boot/dts/at91-ariag25.dts            | 2 +-
 arch/arm/boot/dts/at91-ariettag25.dts         | 2 +-
 arch/arm/boot/dts/at91-cosino.dtsi            | 2 +-
 arch/arm/boot/dts/at91-foxg20.dts             | 2 +-
 arch/arm/boot/dts/at91-kizbox.dts             | 2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi    | 2 +-
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi | 2 +-
 arch/arm/boot/dts/at91-linea.dtsi             | 2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts          | 2 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts         | 2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   | 2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi     | 2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts   | 2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts          | 2 +-
 arch/arm/boot/dts/at91-som60.dtsi             | 2 +-
 arch/arm/boot/dts/at91-vinco.dts              | 2 +-
 arch/arm/boot/dts/at91-wb45n.dtsi             | 2 +-
 arch/arm/boot/dts/at91-wb50n.dtsi             | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi             | 2 +-
 arch/arm/boot/dts/at91rm9200ek.dts            | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9260ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9261ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9263ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9g20.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts        | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi            | 2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi             | 2 +-
 arch/arm/boot/dts/at91sam9rlek.dts            | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             | 2 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi           | 2 +-
 arch/arm/boot/dts/ethernut5.dts               | 2 +-
 arch/arm/boot/dts/mpa1600.dts                 | 2 +-
 arch/arm/boot/dts/pm9g45.dts                  | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi                | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi                | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi                | 2 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi             | 2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi         | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi                | 2 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi       | 2 +-
 arch/arm/boot/dts/tny_a9263.dts               | 2 +-
 arch/arm/boot/dts/usb_a9260.dts               | 2 +-
 arch/arm/boot/dts/usb_a9263.dts               | 2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi       | 2 +-
 51 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 6d7fc9c6c6e0..7da718abbd85 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -26,7 +26,7 @@ chosen {
 		stdout-path = &usart2;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index 2ef39ecbda18..713d18f80356 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -22,7 +22,7 @@ chosen {
 		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
 	};
 
-	memory {
+	memory@20000000 {
 		/* 128 MB, change this for 256 MB revision */
 		reg = <0x20000000 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/at91-ariettag25.dts b/arch/arm/boot/dts/at91-ariettag25.dts
index 2eb494f49078..2c52a71752c2 100644
--- a/arch/arm/boot/dts/at91-ariettag25.dts
+++ b/arch/arm/boot/dts/at91-ariettag25.dts
@@ -15,7 +15,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index 91e386d4872f..ee0f5da6d819 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -20,7 +20,7 @@ chosen {
 		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index c0509c4e5138..7edf057047f8 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -17,7 +17,7 @@ chosen {
 		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 7d938ccf71b0..7add151f6250 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -18,7 +18,7 @@ chosen {
 		stdout-path = &dbgu;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
index af38253a6e7a..25f761065106 100644
--- a/arch/arm/boot/dts/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = &dbgu;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
index fddf267b2d17..d37724c10695 100644
--- a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = &dbgu;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
index 41f163955b1e..533a440d5583 100644
--- a/arch/arm/boot/dts/at91-linea.dtsi
+++ b/arch/arm/boot/dts/at91-linea.dtsi
@@ -13,7 +13,7 @@ / {
 	compatible = "axentia,linea",
 		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index ee8525d5a5da..969d990767fc 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -14,7 +14,7 @@ chosen {
 		bootargs = "console=ttyS0,115200";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
index f475c0b0f1de..1e2a28c2f365 100644
--- a/arch/arm/boot/dts/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -15,7 +15,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 7abf555cd2fe..cf13632edd44 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index 0be184a870eb..710cb72bda5a 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -9,7 +9,7 @@ / {
 	model = "Aries/DENX MA5D4";
 	compatible = "aries,ma5d4", "denx,ma5d4", "atmel,sama5d4", "atmel,sama5";
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 924d9491780d..e5974a17374c 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 0cc1cff13e46..fe432b6b7e95 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-som60.dtsi b/arch/arm/boot/dts/at91-som60.dtsi
index 241682a207c5..39474a112b16 100644
--- a/arch/arm/boot/dts/at91-som60.dtsi
+++ b/arch/arm/boot/dts/at91-som60.dtsi
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = &dbgu;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index 15050fdd479d..a51a3372afa1 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-wb45n.dtsi
index e3d98306ee3a..430c75358086 100644
--- a/arch/arm/boot/dts/at91-wb45n.dtsi
+++ b/arch/arm/boot/dts/at91-wb45n.dtsi
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91-wb50n.dtsi b/arch/arm/boot/dts/at91-wb50n.dtsi
index 1487b893cfa7..74b249bb6351 100644
--- a/arch/arm/boot/dts/at91-wb50n.dtsi
+++ b/arch/arm/boot/dts/at91-wb50n.dtsi
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 0ea0aff2a024..d1181ead18e5 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -49,7 +49,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 1e0bf5afa913..e1ef4e44e663 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -15,7 +15,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index b07578ff214c..82c5d7fd9811 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -46,7 +46,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index 657dc3a420d6..d3446e42b598 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = &dbgu;
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 980cc308fec5..7adc36ca8a46 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -43,7 +43,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index c4ef74fea97c..beed819609e8 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index aea70a32511c..fe45d96239c9 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -45,7 +45,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index bf89cb2bbdd9..71f60576761a 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -16,7 +16,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 86b4e943089a..708e1646b7f4 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -11,7 +11,7 @@ / {
 	model = "Atmel AT91SAM9G20 family SoC";
 	compatible = "atmel,at91sam9g20";
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index c65651549692..6e6e672c0b86 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -13,7 +13,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 1e1b7490ee0a..19fc748a87c5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -51,7 +51,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@70000000 {
 		device_type = "memory";
 		reg = <0x70000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 09b29126f60d..9734667abbfc 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -18,7 +18,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@70000000 {
 		reg = <0x70000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 5c27ead05284..0785389f5507 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -47,7 +47,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 870b83ff6b97..2bc4e6e0a923 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index eb5bea473bc8..5653e70c84b4 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -48,7 +48,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 0de75d3c4f18..1590862f16f2 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 79076e4ed1e0..4cdb05079cc7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -49,7 +49,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 75d2f7fd314f..cdd37f67280b 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -7,7 +7,7 @@
  */
 
 / {
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 052a52f947ce..ad7a0850252a 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -15,7 +15,7 @@ chosen {
 		bootargs = "console=ttyS0,115200 root=/dev/mtdblock0 rw rootfstype=jffs2";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index a5c91c240db9..005c2758e229 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -11,7 +11,7 @@ / {
 	model = "Phontech MPA 1600";
 	compatible = "phontech,mpa1600", "atmel,at91rm9200";
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index f52f5eea430a..c349fd3758a6 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -15,7 +15,7 @@ chosen {
 		bootargs = "console=ttyS0,115200";
 	};
 
-	memory {
+	memory@70000000 {
 		reg = <0x70000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 3e85c2a0d198..04ad6b956471 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -42,7 +42,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ddd7f9b05aa2..c4aecfa4a2be 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -72,7 +72,7 @@ etm_out: endpoint {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 4f9001188511..86137f8d2b45 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -55,7 +55,7 @@ pmu {
 		interrupts = <46 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 65566e4b78d8..384335635792 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -14,7 +14,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
index 9d2563602cbe..5579c955f141 100644
--- a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
@@ -12,7 +12,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 1aca4b462f52..04f24cf752d3 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -53,7 +53,7 @@ cpu@0 {
 		};
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index dd6957b20772..70e5635c78ed 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -10,7 +10,7 @@ chosen {
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock6 rw rootfstype=ubifs";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 2820635952e3..62b7d9f9a926 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -15,7 +15,7 @@ chosen {
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/usb_a9260.dts
index ec8cd86b260d..6cfa83921ac2 100644
--- a/arch/arm/boot/dts/usb_a9260.dts
+++ b/arch/arm/boot/dts/usb_a9260.dts
@@ -16,7 +16,7 @@ chosen {
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index e7a705fddda9..8a0cfbfd0c45 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -15,7 +15,7 @@ chosen {
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/usb_a9g20_common.dtsi
index adbe75024739..7d10b36db1ee 100644
--- a/arch/arm/boot/dts/usb_a9g20_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
@@ -14,7 +14,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
-- 
2.26.2

