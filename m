Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FC4207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE1Hi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34002 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1Hi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF2DA1A0184;
        Thu, 28 May 2020 09:38:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02A7E1A0C42;
        Thu, 28 May 2020 09:38:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 74445402FC;
        Thu, 28 May 2020 15:38:11 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 5/9] dt-bindings: clock: Convert i.MX23 clock to json-schema
Date:   Thu, 28 May 2020 15:27:55 +0800
Message-Id: <1590650879-18288-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX23 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx23-clock.txt      | 70 -----------------
 .../devicetree/bindings/clock/imx23-clock.yaml     | 90 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx23-clock.txt b/Documentation/devicetree/bindings/clock/imx23-clock.txt
deleted file mode 100644
index 8385348..0000000
--- a/Documentation/devicetree/bindings/clock/imx23-clock.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* Clock bindings for Freescale i.MX23
-
-Required properties:
-- compatible: Should be "fsl,imx23-clkctrl"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  The following is a full list of i.MX23
-clocks and IDs.
-
-	Clock		ID
-	------------------
-	ref_xtal	0
-	pll		1
-	ref_cpu		2
-	ref_emi		3
-	ref_pix		4
-	ref_io		5
-	saif_sel	6
-	lcdif_sel	7
-	gpmi_sel	8
-	ssp_sel		9
-	emi_sel		10
-	cpu		11
-	etm_sel		12
-	cpu_pll		13
-	cpu_xtal	14
-	hbus		15
-	xbus		16
-	lcdif_div	17
-	ssp_div		18
-	gpmi_div	19
-	emi_pll		20
-	emi_xtal	21
-	etm_div		22
-	saif_div	23
-	clk32k_div	24
-	rtc		25
-	adc		26
-	spdif_div	27
-	clk32k		28
-	dri		29
-	pwm		30
-	filt		31
-	uart		32
-	ssp		33
-	gpmi		34
-	spdif		35
-	emi		36
-	saif		37
-	lcdif		38
-	etm		39
-	usb		40
-	usb_phy		41
-
-Examples:
-
-clks: clkctrl@80040000 {
-	compatible = "fsl,imx23-clkctrl";
-	reg = <0x80040000 0x2000>;
-	#clock-cells = <1>;
-};
-
-auart0: serial@8006c000 {
-	compatible = "fsl,imx23-auart";
-	reg = <0x8006c000 0x2000>;
-	interrupts = <24 25 23>;
-	clocks = <&clks 32>;
-};
diff --git a/Documentation/devicetree/bindings/clock/imx23-clock.yaml b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
new file mode 100644
index 0000000..0fd21f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx23-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX23
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. The following is a full list of i.MX23
+  clocks and IDs.
+
+        Clock		ID
+        ------------------
+        ref_xtal	0
+        pll		1
+        ref_cpu		2
+        ref_emi		3
+        ref_pix		4
+        ref_io		5
+        saif_sel	6
+        lcdif_sel	7
+        gpmi_sel	8
+        ssp_sel		9
+        emi_sel		10
+        cpu		11
+        etm_sel		12
+        cpu_pll		13
+        cpu_xtal	14
+        hbus		15
+        xbus		16
+        lcdif_div	17
+        ssp_div		18
+        gpmi_div	19
+        emi_pll		20
+        emi_xtal	21
+        etm_div		22
+        saif_div	23
+        clk32k_div	24
+        rtc		25
+        adc		26
+        spdif_div	27
+        clk32k		28
+        dri		29
+        pwm		30
+        filt		31
+        uart		32
+        ssp		33
+        gpmi		34
+        spdif		35
+        emi		36
+        saif		37
+        lcdif		38
+        etm		39
+        usb		40
+        usb_phy		41
+
+properties:
+  compatible:
+    const: fsl,imx23-clkctrl
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
+        compatible = "fsl,imx23-clkctrl";
+        reg = <0x80040000 0x2000>;
+        #clock-cells = <1>;
+    };
+
+    serial@8006c000 {
+        compatible = "fsl,imx23-auart";
+        reg = <0x8006c000 0x2000>;
+        interrupts = <24 25 23>;
+        clocks = <&clks 32>;
+    };
-- 
2.7.4

