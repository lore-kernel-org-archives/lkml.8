Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFED8208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgE1Hi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39174 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgE1HiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04A05200A1E;
        Thu, 28 May 2020 09:38:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3784E200A1D;
        Thu, 28 May 2020 09:38:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 62B1C402FB;
        Thu, 28 May 2020 15:38:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/9] dt-bindings: clock: Convert i.MX28 clock to json-schema
Date:   Thu, 28 May 2020 15:27:54 +0800
Message-Id: <1590650879-18288-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX28 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx28-clock.txt      |  93 -----------------
 .../devicetree/bindings/clock/imx28-clock.yaml     | 113 +++++++++++++++++++++
 2 files changed, 113 insertions(+), 93 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.txt b/Documentation/devicetree/bindings/clock/imx28-clock.txt
deleted file mode 100644
index d84a37d..0000000
--- a/Documentation/devicetree/bindings/clock/imx28-clock.txt
+++ /dev/null
@@ -1,93 +0,0 @@
-* Clock bindings for Freescale i.MX28
-
-Required properties:
-- compatible: Should be "fsl,imx28-clkctrl"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  The following is a full list of i.MX28
-clocks and IDs.
-
-	Clock		ID
-	------------------
-	ref_xtal	0
-	pll0		1
-	pll1		2
-	pll2		3
-	ref_cpu		4
-	ref_emi		5
-	ref_io0		6
-	ref_io1		7
-	ref_pix		8
-	ref_hsadc	9
-	ref_gpmi	10
-	saif0_sel	11
-	saif1_sel	12
-	gpmi_sel	13
-	ssp0_sel	14
-	ssp1_sel	15
-	ssp2_sel	16
-	ssp3_sel	17
-	emi_sel		18
-	etm_sel		19
-	lcdif_sel	20
-	cpu		21
-	ptp_sel		22
-	cpu_pll		23
-	cpu_xtal	24
-	hbus		25
-	xbus		26
-	ssp0_div	27
-	ssp1_div	28
-	ssp2_div	29
-	ssp3_div	30
-	gpmi_div	31
-	emi_pll		32
-	emi_xtal	33
-	lcdif_div	34
-	etm_div		35
-	ptp		36
-	saif0_div	37
-	saif1_div	38
-	clk32k_div	39
-	rtc		40
-	lradc		41
-	spdif_div	42
-	clk32k		43
-	pwm		44
-	uart		45
-	ssp0		46
-	ssp1		47
-	ssp2		48
-	ssp3		49
-	gpmi		50
-	spdif		51
-	emi		52
-	saif0		53
-	saif1		54
-	lcdif		55
-	etm		56
-	fec		57
-	can0		58
-	can1		59
-	usb0		60
-	usb1		61
-	usb0_phy	62
-	usb1_phy	63
-	enet_out	64
-
-Examples:
-
-clks: clkctrl@80040000 {
-	compatible = "fsl,imx28-clkctrl";
-	reg = <0x80040000 0x2000>;
-	#clock-cells = <1>;
-};
-
-auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
-	reg = <0x8006a000 0x2000>;
-	interrupts = <112 70 71>;
-	clocks = <&clks 45>;
-};
diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.yaml b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
new file mode 100644
index 0000000..e4a7038
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx28-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX28
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. The following is a full list of i.MX28
+  clocks and IDs.
+
+        Clock		ID
+        ------------------
+        ref_xtal	0
+        pll0		1
+        pll1		2
+        pll2		3
+        ref_cpu		4
+        ref_emi		5
+        ref_io0		6
+        ref_io1		7
+        ref_pix		8
+        ref_hsadc	9
+        ref_gpmi	10
+        saif0_sel	11
+        saif1_sel	12
+        gpmi_sel	13
+        ssp0_sel	14
+        ssp1_sel	15
+        ssp2_sel	16
+        ssp3_sel	17
+        emi_sel		18
+        etm_sel		19
+        lcdif_sel	20
+        cpu		21
+        ptp_sel		22
+        cpu_pll		23
+        cpu_xtal	24
+        hbus		25
+        xbus		26
+        ssp0_div	27
+        ssp1_div	28
+        ssp2_div	29
+        ssp3_div	30
+        gpmi_div	31
+        emi_pll		32
+        emi_xtal	33
+        lcdif_div	34
+        etm_div		35
+        ptp		36
+        saif0_div	37
+        saif1_div	38
+        clk32k_div	39
+        rtc		40
+        lradc		41
+        spdif_div	42
+        clk32k		43
+        pwm		44
+        uart		45
+        ssp0		46
+        ssp1		47
+        ssp2		48
+        ssp3		49
+        gpmi		50
+        spdif		51
+        emi		52
+        saif0		53
+        saif1		54
+        lcdif		55
+        etm		56
+        fec		57
+        can0		58
+        can1		59
+        usb0		60
+        usb1		61
+        usb0_phy	62
+        usb1_phy	63
+        enet_out	64
+
+properties:
+  compatible:
+    const: fsl,imx28-clkctrl
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+examples:
+  - |
+    clock-controller@80040000 {
+        compatible = "fsl,imx28-clkctrl";
+        reg = <0x80040000 0x2000>;
+        #clock-cells = <1>;
+    };
+
+    serial@8006a000 {
+        compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+        reg = <0x8006a000 0x2000>;
+        interrupts = <112 70 71>;
+        clocks = <&clks 45>;
+    };
-- 
2.7.4

