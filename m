Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E507C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230D32073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="PdjXEc3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBKVnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:43:00 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:8857 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBKVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581457309;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BRx4A/2BZ9iAXxHIzvSIgcM006QIyV49GXyT24CvguM=;
        b=PdjXEc3aqPO9weOKkLX3nka0CwucPiTFbSngYI/e+WhI25Xp3wVRNu9f8BOUC+cazP
        CuSEoKN2yixRCF3U0yUO9mi6MOrQgHQDRA1wiUjIDMG0B2veOvglXqjSEcG8Vw47KeKD
        jaw9cFKBHsZEugqeqPaBCSq3Ja+2/pWTh0zSF+sYXSL6Qa2uXR4OP3J+U1AJJ49VpsjX
        JtQjqoEUnob98Q9MGcyOf/tRv62dMZ+XyutA+BVFss1A6WN6L6ovIhVUFt6pv6TKGoWo
        Sormdooo/llT6ICoITn2eJBzLmostFqp7MHAgcVW9IYWBpOTF37Jr5CwlfijZsEuzU4R
        y3GQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0P2mp10IM"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1BLfc0EN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 11 Feb 2020 22:41:38 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        Alex Smith <alex.smith@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH 07/14] MIPS: DTS: CI20: fix PMU definitions for ACT8600
Date:   Tue, 11 Feb 2020 22:41:24 +0100
Message-Id: <aa9725056a1d2bfb490a1c912f34302de0e27fad.1581457290.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581457290.git.hns@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a ACT8600 on the CI20 board and the bindings of the
ACT8865 driver have changed without updating the CI20 device
tree. Therefore the PMU can not be probed successfully and
is running in power-on reset state.

Fix DT to match the latest act8865-regulator bindings.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 48 ++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 37b93166bf22..e02a19db7ef1 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -148,6 +148,8 @@
 	pinctrl-0 = <&pins_uart4>;
 };
 
+#include <dt-bindings/regulator/active-semi,8865-regulator.h>
+
 &i2c0 {
 	status = "okay";
 
@@ -161,65 +163,81 @@
 		reg = <0x5a>;
 		status = "okay";
 
+/*
+Optional input supply properties:
+- for act8600:
+  - vp1-supply: The input supply for DCDC_REG1
+  - vp2-supply: The input supply for DCDC_REG2
+  - vp3-supply: The input supply for DCDC_REG3
+  - inl-supply: The input supply for LDO_REG5, LDO_REG6, LDO_REG7 and LDO_REG8
+  SUDCDC_REG4, LDO_REG9 and LDO_REG10 do not have separate supplies.
+*/
+
 		regulators {
 			vddcore: SUDCDC1 {
-				regulator-name = "VDDCORE";
+				regulator-name = "DCDC_REG1";
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 			};
 			vddmem: SUDCDC2 {
-				regulator-name = "VDDMEM";
+				regulator-name = "DCDC_REG2";
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 			vcc_33: SUDCDC3 {
-				regulator-name = "VCC33";
+				regulator-name = "DCDC_REG3";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 			vcc_50: SUDCDC4 {
-				regulator-name = "VCC50";
+				regulator-name = "SUDCDC_REG4";
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-always-on;
 			};
 			vcc_25: LDO_REG5 {
-				regulator-name = "VCC25";
+				regulator-name = "LDO_REG5";
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
 			wifi_io: LDO_REG6 {
-				regulator-name = "WIFIIO";
+				regulator-name = "LDO_REG6";
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
 			vcc_28: LDO_REG7 {
-				regulator-name = "VCC28";
+				regulator-name = "LDO_REG7";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-always-on;
 			};
 			vcc_15: LDO_REG8 {
-				regulator-name = "VCC15";
+				regulator-name = "LDO_REG8";
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
-			vcc_18: LDO_REG9 {
-				regulator-name = "VCC18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
+			vrtc_18: LDO_REG9 {
+				regulator-name = "LDO_REG9";
+				/* Despite the datasheet stating 3.3V for REG9 and
+				   driver expecting that, REG9 outputs 1.8V.
+				   Likely the CI20 uses a chip variant.
+				   Since it is a simple on/off LDO the exact values
+				   do not matter.
+				*/
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 			vcc_11: LDO_REG10 {
-				regulator-name = "VCC11";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-name = "LDO_REG10";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 			};
 		};
-- 
2.23.0

