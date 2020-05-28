Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2750C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBFF20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgE1Onz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:43:55 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44092 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgE1Onr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:43:47 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 19DD067A7D5;
        Thu, 28 May 2020 16:43:43 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 28 May
 2020 16:43:42 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 28 May 2020 16:43:42 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] ARM: dts: Move watchdog from Kontron i.MX6UL/ULL board to
 SoM
Thread-Topic: [PATCH 1/2] ARM: dts: Move watchdog from Kontron i.MX6UL/ULL
 board to SoM
Thread-Index: AQHWNP5irO3mzmVdf0KZsIQGwMz0Bw==
Date:   Thu, 28 May 2020 14:43:42 +0000
Message-ID: <20200528144312.25980-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 19DD067A7D5.AF5E3
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The watchdog's WDOG_ANY signal is used to trigger a POR of the SoC,
if a soft reset is issued. As the SoM hardware connects the WDOG_ANY
and the POR signals, the watchdog node itself and the pin
configuration should be part of the common SoM devicetree.
Let's move it from the baseboard's devicetree to its proper place.

Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
Cc: stable@vger.kernel.org
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi       | 13 -------------
 .../boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi   | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
index f05e91841202..53a25fba34f6 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
@@ -232,13 +232,6 @@
 	status = "okay";
 };
 
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
 &iomuxc {
 	pinctrl-0 = <&pinctrl_reset_out &pinctrl_gpio>;
 
@@ -409,10 +402,4 @@
 			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
 		>;
 	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO09__WDOG1_WDOG_ANY	0x30b0
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
index a17af4d9bfdf..fc316408721d 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
@@ -57,6 +57,13 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_reset_out>;
@@ -106,4 +113,10 @@
 			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x1b0b0
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
-- 
2.17.1
