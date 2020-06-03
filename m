Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79911C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F9B2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgFCUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:04:02 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49785 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgFCUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:03:51 -0400
Received: from [78.134.115.170] (port=37458 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jgZc4-005dPA-9G; Wed, 03 Jun 2020 22:03:48 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [RFC 3/4] regulator: lp87565: dt: add LP87524-Q1 variant
Date:   Wed,  3 Jun 2020 22:03:18 +0200
Message-Id: <20200603200319.16184-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200603200319.16184-1-luca@lucaceresoli.net>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LP87524-Q1 to the lp87565 bindings document along with an example.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../devicetree/bindings/mfd/lp87565.txt       | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
index b75ae23a1ef3..839eac6b75c2 100644
--- a/Documentation/devicetree/bindings/mfd/lp87565.txt
+++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
@@ -1,7 +1,8 @@
 TI LP87565 PMIC MFD driver
 
 Required properties:
-  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
+  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1",
+			"ti,lp87524-q1"
   - reg:		I2C slave address.
   - gpio-controller:	Marks the device node as a GPIO Controller.
   - #gpio-cells:	Should be two.  The first cell is the pin number and
@@ -64,3 +65,47 @@ lp87561_pmic: pmic@62 {
 		};
 	};
 };
+
+Example for the TI LP87524-Q1 PMIC (four 1-phase output configuration):
+
+lp87524_pmic: pmic@60 {
+	compatible = "ti,lp87524-q1";
+	reg = <0x60>;
+	gpio-controller;
+	#gpio-cells = <2>;
+
+	buck0-in-supply = <&vdd_5v0>;
+	buck1-in-supply = <&vdd_5v0>;
+	buck2-in-supply = <&vdd_5v0>;
+	buck3-in-supply = <&vdd_5v0>;
+
+	regulators {
+		buck0_reg: buck0 {
+			regulator-name = "buck0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		buck1_reg: buck1 {
+			regulator-name = "buck1";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-always-on;
+		};
+
+		buck2_reg: buck2 {
+			regulator-name = "buck2";
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <950000>;
+			regulator-always-on;
+		};
+
+		buck3_reg: buck3 {
+			regulator-name = "buck3";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+};
-- 
2.27.0

