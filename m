Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5206C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E602075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDGVM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:12:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52747 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgDGVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:12:56 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A228FFF803;
        Tue,  7 Apr 2020 21:12:50 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 1/5] arm: dts: linksys: rename rango to wrt3200acm
Date:   Tue,  7 Apr 2020 11:08:11 -1000
Message-Id: <20200407210816.866084-2-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys uses internally the codename "rango" for a device sold under the
name of "Linksys WRT3200ACM", which is already reflected in the device
tree `model`. However the `compatible` list only contains the codename
`linksys,rango` which does not relate to the common name.

This patch renames the `dts` file to the sanitized model name and
prepends `linksys,wrt3200acm` to the `compatible` list to simplify the
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
 ....dts => armada-385-linksys-wrt3200acm.dts} | 26 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/boot/dts/{armada-385-linksys-rango.dts => armada-385-linksys-wrt3200acm.dts} (83%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..a0df7f97cc44 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1282,8 +1282,8 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-cobra.dtb \
-	armada-385-linksys-rango.dtb \
 	armada-385-linksys-shelby.dtb \
+	armada-385-linksys-wrt3200acm.dtb \
 	armada-385-synology-ds116.dtb \
 	armada-385-turris-omnia.dtb \
 	armada-388-clearfog.dtb \
diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/armada-385-linksys-wrt3200acm.dts
similarity index 83%
rename from arch/arm/boot/dts/armada-385-linksys-rango.dts
rename to arch/arm/boot/dts/armada-385-linksys-wrt3200acm.dts
index 3c4af57ec2b9..bf7b546e3344 100644
--- a/arch/arm/boot/dts/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-wrt3200acm.dts
@@ -12,43 +12,43 @@
 
 / {
 	model = "Linksys WRT3200ACM";
-	compatible = "linksys,rango", "linksys,armada385", "marvell,armada385",
-		     "marvell,armada380";
+	compatible = "linksys,wrt3200acm", "linksys,rango", "linksys,armada385",
+		     "marvell,armada385", "marvell,armada380";
 };
 
 &expander0 {
 	wan_amber@0 {
-		label = "rango:amber:wan";
+		label = "wrt3200acm:amber:wan";
 		reg = <0x0>;
 	};
 
 	wan_white@1 {
-		label = "rango:white:wan";
+		label = "wrt3200acm:white:wan";
 		reg = <0x1>;
 	};
 
 	usb2@5 {
-		label = "rango:white:usb2";
+		label = "wrt3200acm:white:usb2";
 		reg = <0x5>;
 	};
 
 	usb3_1@6 {
-		label = "rango:white:usb3_1";
+		label = "wrt3200acm:white:usb3_1";
 		reg = <0x6>;
 	};
 
 	usb3_2@7 {
-		label = "rango:white:usb3_2";
+		label = "wrt3200acm:white:usb3_2";
 		reg = <0x7>;
 	};
 
 	wps_white@8 {
-		label = "rango:white:wps";
+		label = "wrt3200acm:white:wps";
 		reg = <0x8>;
 	};
 
 	wps_amber@9 {
-		label = "rango:amber:wps";
+		label = "wrt3200acm:amber:wps";
 		reg = <0x9>;
 	};
 };
@@ -56,22 +56,22 @@ wps_amber@9 {
 &gpio_leds {
 	power {
 		gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
-		label = "rango:white:power";
+		label = "wrt3200acm:white:power";
 	};
 
 	sata {
 		gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
-		label = "rango:white:sata";
+		label = "wrt3200acm:white:sata";
 	};
 
 	wlan_2g {
 		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		label = "rango:white:wlan_2g";
+		label = "wrt3200acm:white:wlan_2g";
 	};
 
 	wlan_5g {
 		gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
-		label = "rango:white:wlan_5g";
+		label = "wrt3200acm:white:wlan_5g";
 	};
 };
 
-- 
2.25.1

