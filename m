Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F15C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6312B20769
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDGVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:13:04 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34629 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgDGVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:13:03 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A84DBFF805;
        Tue,  7 Apr 2020 21:12:56 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 2/5] arm: dts: linksys: rename mamba to wrt1900ac
Date:   Tue,  7 Apr 2020 11:08:12 -1000
Message-Id: <20200407210816.866084-3-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys uses internally the codename "mamba" for a device sold under
the name of "Linksys WRT1900AC", which is already reflected in the
device tree `model`. However the `compatible` list only contains the
codename `linksys,mamba` which does not relate to the common name.

This patch renames the `dts` file to the sanitized model name and
prepends `linksys,wrt1900ac` to the `compatible` list to simplify the
device relation.

Signed-off-by: Paul Spooren <mail@aparcar.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC: Daniel Golle <daniel@makrotopia.org>
CC: Adrian Schmutzler <freifunk@adrianschmutzler.de>
---
 arch/arm/boot/dts/Makefile                    |  2 +-
 ...ba.dts => armada-xp-linksys-wrt1900ac.dts} | 27 ++++++++++---------
 2 files changed, 15 insertions(+), 14 deletions(-)
 rename arch/arm/boot/dts/{armada-xp-linksys-mamba.dts => armada-xp-linksys-wrt1900ac.dts} (92%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a0df7f97cc44..cf288adb8fe0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1302,7 +1302,7 @@ dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-db-xc3-24g4xg.dtb \
 	armada-xp-gp.dtb \
 	armada-xp-lenovo-ix4-300d.dtb \
-	armada-xp-linksys-mamba.dtb \
+	armada-xp-linksys-wrt1900ac.dtb \
 	armada-xp-matrix.dtb \
 	armada-xp-netgear-rn2120.dtb \
 	armada-xp-openblocks-ax3-4.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-wrt1900ac.dts
similarity index 92%
rename from arch/arm/boot/dts/armada-xp-linksys-mamba.dts
rename to arch/arm/boot/dts/armada-xp-linksys-wrt1900ac.dts
index 8480a16919a0..2644870fec2c 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-wrt1900ac.dts
@@ -23,8 +23,9 @@
 
 / {
 	model = "Linksys WRT1900AC";
-	compatible = "linksys,mamba", "marvell,armadaxp-mv78230",
-		     "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "linksys,wrt1900ac", "linksys,mamba",
+		     "marvell,armadaxp-mv78230", "marvell,armadaxp",
+		     "marvell,armada-370-xp";
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
@@ -110,53 +111,53 @@ tlc59116@68 {
 					reg = <0x68>;
 
 					wan_amber@0 {
-						label = "mamba:amber:wan";
+						label = "wrt1900ac:amber:wan";
 						reg = <0x0>;
 					};
 
 					wan_white@1 {
-						label = "mamba:white:wan";
+						label = "wrt1900ac:white:wan";
 						reg = <0x1>;
 					};
 
 					wlan_2g@2 {
-						label = "mamba:white:wlan_2g";
+						label = "wrt1900ac:white:wlan_2g";
 						reg = <0x2>;
 					};
 
 					wlan_5g@3 {
-						label = "mamba:white:wlan_5g";
+						label = "wrt1900ac:white:wlan_5g";
 						reg = <0x3>;
 					};
 
 					esata@4 {
-						label = "mamba:white:esata";
+						label = "wrt1900ac:white:esata";
 						reg = <0x4>;
 						linux,default-trigger = "disk-activity";
 					};
 
 					usb2@5 {
-						label = "mamba:white:usb2";
+						label = "wrt1900ac:white:usb2";
 						reg = <0x5>;
 					};
 
 					usb3_1@6 {
-						label = "mamba:white:usb3_1";
+						label = "wrt1900ac:white:usb3_1";
 						reg = <0x6>;
 					};
 
 					usb3_2@7 {
-						label = "mamba:white:usb3_2";
+						label = "wrt1900ac:white:usb3_2";
 						reg = <0x7>;
 					};
 
 					wps_white@8 {
-						label = "mamba:white:wps";
+						label = "wrt1900ac:white:wps";
 						reg = <0x8>;
 					};
 
 					wps_amber@9 {
-						label = "mamba:amber:wps";
+						label = "wrt1900ac:amber:wps";
 						reg = <0x9>;
 					};
 				};
@@ -198,7 +199,7 @@ gpio-leds {
 		pinctrl-names = "default";
 
 		power {
-			label = "mamba:white:power";
+			label = "wrt1900ac:white:power";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
-- 
2.25.1

