Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CC208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgE1Hiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39154 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgE1HiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B73200A1A;
        Thu, 28 May 2020 09:38:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5606200A1E;
        Thu, 28 May 2020 09:38:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 60C8A40319;
        Thu, 28 May 2020 15:38:07 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/9] dt-bindings: clock: Convert i.MX31 clock to json-schema
Date:   Thu, 28 May 2020 15:27:53 +0800
Message-Id: <1590650879-18288-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX31 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx31-clock.txt      |  90 ----------------
 .../devicetree/bindings/clock/imx31-clock.yaml     | 118 +++++++++++++++++++++
 2 files changed, 118 insertions(+), 90 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx31-clock.txt b/Documentation/devicetree/bindings/clock/imx31-clock.txt
deleted file mode 100644
index 0a29109..0000000
--- a/Documentation/devicetree/bindings/clock/imx31-clock.txt
+++ /dev/null
@@ -1,90 +0,0 @@
-* Clock bindings for Freescale i.MX31
-
-Required properties:
-- compatible: Should be "fsl,imx31-ccm"
-- reg: Address and length of the register set
-- interrupts: Should contain CCM interrupt
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  The following is a full list of i.MX31
-clocks and IDs.
-
-	Clock		    ID
-	-----------------------
-	dummy	             0
-	ckih                 1
-	ckil                 2
-	mpll                 3
-	spll                 4
-	upll                 5
-	mcu_main             6
-	hsp                  7
-	ahb                  8
-	nfc                  9
-	ipg                  10
-	per_div              11
-	per                  12
-	csi_sel              13
-	fir_sel              14
-	csi_div              15
-	usb_div_pre          16
-	usb_div_post         17
-	fir_div_pre          18
-	fir_div_post         19
-	sdhc1_gate           20
-	sdhc2_gate           21
-	gpt_gate             22
-	epit1_gate           23
-	epit2_gate           24
-	iim_gate             25
-	ata_gate             26
-	sdma_gate            27
-	cspi3_gate           28
-	rng_gate             29
-	uart1_gate           30
-	uart2_gate           31
-	ssi1_gate            32
-	i2c1_gate            33
-	i2c2_gate            34
-	i2c3_gate            35
-	hantro_gate          36
-	mstick1_gate         37
-	mstick2_gate         38
-	csi_gate             39
-	rtc_gate             40
-	wdog_gate            41
-	pwm_gate             42
-	sim_gate             43
-	ect_gate             44
-	usb_gate             45
-	kpp_gate             46
-	ipu_gate             47
-	uart3_gate           48
-	uart4_gate           49
-	uart5_gate           50
-	owire_gate           51
-	ssi2_gate            52
-	cspi1_gate           53
-	cspi2_gate           54
-	gacc_gate            55
-	emi_gate             56
-	rtic_gate            57
-	firi_gate            58
-
-Examples:
-
-clks: ccm@53f80000{
-	compatible = "fsl,imx31-ccm";
-	reg = <0x53f80000 0x4000>;
-	interrupts = <31>, <53>;
-	#clock-cells = <1>;
-};
-
-uart1: serial@43f90000 {
-	compatible = "fsl,imx31-uart", "fsl,imx21-uart";
-	reg = <0x43f90000 0x4000>;
-	interrupts = <45>;
-	clocks = <&clks 10>, <&clks 30>;
-	clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/clock/imx31-clock.yaml b/Documentation/devicetree/bindings/clock/imx31-clock.yaml
new file mode 100644
index 0000000..2d9220e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx31-clock.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx31-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX31
+
+maintainers:
+  - Fabio Estevam <fabio.estevam@freescale.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. The following is a full list of i.MX31
+  clocks and IDs.
+
+        Clock		    ID
+        -----------------------
+        dummy	             0
+        ckih                 1
+        ckil                 2
+        mpll                 3
+        spll                 4
+        upll                 5
+        mcu_main             6
+        hsp                  7
+        ahb                  8
+        nfc                  9
+        ipg                  10
+        per_div              11
+        per                  12
+        csi_sel              13
+        fir_sel              14
+        csi_div              15
+        usb_div_pre          16
+        usb_div_post         17
+        fir_div_pre          18
+        fir_div_post         19
+        sdhc1_gate           20
+        sdhc2_gate           21
+        gpt_gate             22
+        epit1_gate           23
+        epit2_gate           24
+        iim_gate             25
+        ata_gate             26
+        sdma_gate            27
+        cspi3_gate           28
+        rng_gate             29
+        uart1_gate           30
+        uart2_gate           31
+        ssi1_gate            32
+        i2c1_gate            33
+        i2c2_gate            34
+        i2c3_gate            35
+        hantro_gate          36
+        mstick1_gate         37
+        mstick2_gate         38
+        csi_gate             39
+        rtc_gate             40
+        wdog_gate            41
+        pwm_gate             42
+        sim_gate             43
+        ect_gate             44
+        usb_gate             45
+        kpp_gate             46
+        ipu_gate             47
+        uart3_gate           48
+        uart4_gate           49
+        uart5_gate           50
+        owire_gate           51
+        ssi2_gate            52
+        cspi1_gate           53
+        cspi2_gate           54
+        gacc_gate            55
+        emi_gate             56
+        rtic_gate            57
+        firi_gate            58
+
+properties:
+  compatible:
+    const: fsl,imx31-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: CCM provides 2 interrupt requests, request 1 is to generate
+      interrupt for DVFS when a frequency change is requested, request 2 is
+      to generate interrupt for DPTC when a voltage change is requested.
+    items:
+      - description: CCM DVFS interrupt request 1
+      - description: CCM DPTC interrupt request 2
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+examples:
+  - |
+    clock-controller@53f80000 {
+        compatible = "fsl,imx31-ccm";
+        reg = <0x53f80000 0x4000>;
+        interrupts = <31>, <53>;
+        #clock-cells = <1>;
+    };
+
+    serial@43f90000 {
+        compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+        reg = <0x43f90000 0x4000>;
+        interrupts = <45>;
+        clocks = <&clks 10>, <&clks 30>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

