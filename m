Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DCC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C1B20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDGVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:13:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42063 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:13:22 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 61CE5FF803;
        Tue,  7 Apr 2020 21:13:14 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 5/5] arm: dts: linksys: rename shelby to wrt1900acs
Date:   Tue,  7 Apr 2020 11:08:15 -1000
Message-Id: <20200407210816.866084-6-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys uses internally the codename "shelby" for a device sold under
the name of "Linksys WRT1900ACS", which is already reflected in the
device tree `model`. However the `compatible` list only contains the
codename `linksys,shelby` which does not relate to the common name.

This patch renames the `dts` file to the sanitized model name and
prepends `linksys,wrt1900acs` to the `compatible` list to simplify the
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
 ....dts => armada-385-linksys-wrt1900acs.dts} | 25 ++++++++++---------
 2 files changed, 14 insertions(+), 13 deletions(-)
 rename arch/arm/boot/dts/{armada-385-linksys-shelby.dts => armada-385-linksys-wrt1900acs.dts} (80%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8482bec35af4..f59bcb23db91 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1280,9 +1280,9 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-clearfog-gtr-l8.dtb \
 	armada-385-db-88f6820-amc.dtb \
 	armada-385-db-ap.dtb \
-	armada-385-linksys-shelby.dtb \
 	armada-385-linksys-wrt1200ac.dtb \
 	armada-385-linksys-wrt1900ac-v2.dtb \
+	armada-385-linksys-wrt1900acs.dtb \
 	armada-385-linksys-wrt3200acm.dtb \
 	armada-385-synology-ds116.dtb \
 	armada-385-turris-omnia.dtb \
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-wrt1900acs.dts
similarity index 80%
rename from arch/arm/boot/dts/armada-385-linksys-shelby.dts
rename to arch/arm/boot/dts/armada-385-linksys-wrt1900acs.dts
index 3451cd3e5dff..866f3fad19fa 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-wrt1900acs.dts
@@ -10,64 +10,65 @@
 
 / {
 	model = "Linksys WRT1900ACS";
-	compatible = "linksys,shelby", "linksys,armada385", "marvell,armada385",
+	compatible = "linksys,wrt1900acs", "linksys,shelby",
+		     "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
 };
 
 &expander0 {
 	wan_amber@0 {
-		label = "shelby:amber:wan";
+		label = "wrt1900acs:amber:wan";
 		reg = <0x0>;
 	};
 
 	wan_white@1 {
-		label = "shelby:white:wan";
+		label = "wrt1900acs:white:wan";
 		reg = <0x1>;
 	};
 
 	wlan_2g@2 {
-		label = "shelby:white:wlan_2g";
+		label = "wrt1900acs:white:wlan_2g";
 		reg = <0x2>;
 	};
 
 	wlan_5g@3 {
-		label = "shelby:white:wlan_5g";
+		label = "wrt1900acs:white:wlan_5g";
 		reg = <0x3>;
 	};
 
 	usb2@5 {
-		label = "shelby:white:usb2";
+		label = "wrt1900acs:white:usb2";
 		reg = <0x5>;
 	};
 
 	usb3_1@6 {
-		label = "shelby:white:usb3_1";
+		label = "wrt1900acs:white:usb3_1";
 		reg = <0x6>;
 	};
 
 	usb3_2@7 {
-		label = "shelby:white:usb3_2";
+		label = "wrt1900acs:white:usb3_2";
 		reg = <0x7>;
 	};
 
 	wps_white@8 {
-		label = "shelby:white:wps";
+		label = "wrt1900acs:white:wps";
 		reg = <0x8>;
 	};
 
 	wps_amber@9 {
-		label = "shelby:amber:wps";
+		label = "wrt1900acs:amber:wps";
 		reg = <0x9>;
 	};
 };
 
 &gpio_leds {
 	power {
-		label = "shelby:white:power";
+		label = "wrt1900acs:white:power";
 	};
 
 	sata {
-		label = "shelby:white:sata";
+		label = "wrt1900acs:white:sata";
 	};
 };
 
-- 
2.25.1

