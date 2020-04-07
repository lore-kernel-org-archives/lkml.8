Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97AC20769
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDGVNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:13:16 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45737 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:13:15 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B9121FF802;
        Tue,  7 Apr 2020 21:13:08 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 4/5] arm: dts: linksys: rename caiman to wrt1200ac
Date:   Tue,  7 Apr 2020 11:08:14 -1000
Message-Id: <20200407210816.866084-5-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys uses internally the codename "caiman" for a device sold under
the name of "Linksys WRT1200AC", which is already reflected in the
device tree `model`. However the `compatible` list only contains the
codename `linksys,caiman` which does not relate to the common name.

This patch renames the `dts` file to the sanitized model name and
prepends `linksys,wrt1200ac` to the `compatible` list to simplify the
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
 ...n.dts => armada-385-linksys-wrt1200ac.dts} | 26 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/boot/dts/{armada-385-linksys-caiman.dts => armada-385-linksys-wrt1200ac.dts} (80%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index be45b5fb4f95..8482bec35af4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1280,8 +1280,8 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-clearfog-gtr-l8.dtb \
 	armada-385-db-88f6820-amc.dtb \
 	armada-385-db-ap.dtb \
-	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-shelby.dtb \
+	armada-385-linksys-wrt1200ac.dtb \
 	armada-385-linksys-wrt1900ac-v2.dtb \
 	armada-385-linksys-wrt3200acm.dtb \
 	armada-385-synology-ds116.dtb \
diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-wrt1200ac.dts
similarity index 80%
rename from arch/arm/boot/dts/armada-385-linksys-caiman.dts
rename to arch/arm/boot/dts/armada-385-linksys-wrt1200ac.dts
index a03050c97084..acc8338987f5 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-wrt1200ac.dts
@@ -10,64 +10,64 @@
 
 / {
 	model = "Linksys WRT1200AC";
-	compatible = "linksys,caiman", "linksys,armada385", "marvell,armada385",
-		     "marvell,armada380";
+	compatible = "linksys,wrt1200ac", "linksys,caiman", "linksys,armada385",
+		     "marvell,armada385", "marvell,armada380";
 };
 
 &expander0 {
 	wan_amber@0 {
-		label = "caiman:amber:wan";
+		label = "wrt1200ac:amber:wan";
 		reg = <0x0>;
 	};
 
 	wan_white@1 {
-		label = "caiman:white:wan";
+		label = "wrt1200ac:white:wan";
 		reg = <0x1>;
 	};
 
 	wlan_2g@2 {
-		label = "caiman:white:wlan_2g";
+		label = "wrt1200ac:white:wlan_2g";
 		reg = <0x2>;
 	};
 
 	wlan_5g@3 {
-		label = "caiman:white:wlan_5g";
+		label = "wrt1200ac:white:wlan_5g";
 		reg = <0x3>;
 	};
 
 	usb2@5 {
-		label = "caiman:white:usb2";
+		label = "wrt1200ac:white:usb2";
 		reg = <0x5>;
 	};
 
 	usb3_1@6 {
-		label = "caiman:white:usb3_1";
+		label = "wrt1200ac:white:usb3_1";
 		reg = <0x6>;
 	};
 
 	usb3_2@7 {
-		label = "caiman:white:usb3_2";
+		label = "wrt1200ac:white:usb3_2";
 		reg = <0x7>;
 	};
 
 	wps_white@8 {
-		label = "caiman:white:wps";
+		label = "wrt1200ac:white:wps";
 		reg = <0x8>;
 	};
 
 	wps_amber@9 {
-		label = "caiman:amber:wps";
+		label = "wrt1200ac:amber:wps";
 		reg = <0x9>;
 	};
 };
 
 &gpio_leds {
 	power {
-		label = "caiman:white:power";
+		label = "wrt1200ac:white:power";
 	};
 
 	sata {
-		label = "caiman:white:sata";
+		label = "wrt1200ac:white:sata";
 	};
 };
 
-- 
2.25.1

