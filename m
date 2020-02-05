Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4ACC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9E0217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBEObU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:20 -0500
Received: from comms.puri.sm ([159.203.221.185]:49016 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgBEObP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9D9F9E0DCB;
        Wed,  5 Feb 2020 06:31:15 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nPtQJje9XwOq; Wed,  5 Feb 2020 06:31:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 08/12] arm64: dts: librem5-devkit: add a battery for the bq25896 to monitor
Date:   Wed,  5 Feb 2020 15:29:59 +0100
Message-Id: <20200205143003.28408-9-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add a simple-battery with default power capacity

Discharge curve comes from the panasonic NCR18650B datasheet

https://www.batteryspace.com/prod-specs/NCR18650B.pdf

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 6a8f6cee96cf..4957acc512d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -26,6 +26,22 @@
 		power-supply = <&reg_22v4_p>;
 	};
 
+	bat: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3000000>;
+		voltage-max-design-microvolt = <4192000>;
+		energy-full-design-microwatt-hours = <11700000>;
+		charge-full-design-microamp-hours = <3250000>;
+		precharge-current-microamp = <130000>;
+		charge-term-current-microamp = <66000>;
+		constant-charge-current-max-microamp = <1600000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <25>;
+		ocv-capacity-table-0 = <4192000 100>, <3750000 85>, <3650000 68>,
+			<3500000 51>, <3400000 34>, <3250000 17>, <3000000 0>;
+	};
+
 	chosen {
 		stdout-path = &uart1;
 	};
@@ -480,6 +496,7 @@
 		ti,minimum-sys-voltage = <3000000>; /* 3V */
 		ti,boost-voltage = <5000000>; /* 5V */
 		ti,boost-max-current = <50000>; /* 50mA */
+		monitored-battery = <&bat>;
 	};
 };
 
-- 
2.20.1

