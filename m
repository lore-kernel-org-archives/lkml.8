Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6C420723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgE2Gb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:31:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43250 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Gb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:31:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 19940200087;
        Fri, 29 May 2020 08:31:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 985C9200DAC;
        Fri, 29 May 2020 08:31:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DBC31402A7;
        Fri, 29 May 2020 14:31:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: clock: Convert i.MX8QXP LPCG to json-schema
Date:   Fri, 29 May 2020 14:21:39 +0800
Message-Id: <1590733299-12051-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX8QXP LPCG binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     | 51 ---------------
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
deleted file mode 100644
index 965cfa4..0000000
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* NXP i.MX8QXP LPCG (Low-Power Clock Gating) Clock bindings
-
-The Low-Power Clock Gate (LPCG) modules contain a local programming
-model to control the clock gates for the peripherals. An LPCG module
-is used to locally gate the clocks for the associated peripheral.
-
-Note:
-This level of clock gating is provided after the clocks are generated
-by the SCU resources and clock controls. Thus even if the clock is
-enabled by these control bits, it might still not be running based
-on the base resource.
-
-Required properties:
-- compatible:	Should be one of:
-		  "fsl,imx8qxp-lpcg-adma",
-		  "fsl,imx8qxp-lpcg-conn",
-		  "fsl,imx8qxp-lpcg-dc",
-		  "fsl,imx8qxp-lpcg-dsp",
-		  "fsl,imx8qxp-lpcg-gpu",
-		  "fsl,imx8qxp-lpcg-hsio",
-		  "fsl,imx8qxp-lpcg-img",
-		  "fsl,imx8qxp-lpcg-lsio",
-		  "fsl,imx8qxp-lpcg-vpu"
-- reg:		Address and length of the register set
-- #clock-cells:	Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-See the full list of clock IDs from:
-include/dt-bindings/clock/imx8qxp-clock.h
-
-Examples:
-
-#include <dt-bindings/clock/imx8qxp-clock.h>
-
-conn_lpcg: clock-controller@5b200000 {
-	compatible = "fsl,imx8qxp-lpcg-conn";
-	reg = <0x5b200000 0xb0000>;
-	#clock-cells = <1>;
-};
-
-usdhc1: mmc@5b010000 {
-	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-	interrupt-parent = <&gic>;
-	interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-	reg = <0x5b010000 0x10000>;
-	clocks = <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK>,
-		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_PER_CLK>,
-		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_HCLK>;
-	clock-names = "ipg", "per", "ahb";
-};
diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
new file mode 100644
index 0000000..d5b6825
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx8qxp-lpcg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8QXP LPCG (Low-Power Clock Gating) Clock bindings
+
+maintainers:
+  - Aisheng Dong <aisheng.dong@nxp.com>
+
+description: |
+  The Low-Power Clock Gate (LPCG) modules contain a local programming
+  model to control the clock gates for the peripherals. An LPCG module
+  is used to locally gate the clocks for the associated peripheral.
+
+  This level of clock gating is provided after the clocks are generated
+  by the SCU resources and clock controls. Thus even if the clock is
+  enabled by these control bits, it might still not be running based
+  on the base resource.
+
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See the full list of clock IDs from:
+  include/dt-bindings/clock/imx8-clock.h
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-lpcg-adma
+      - fsl,imx8qxp-lpcg-conn
+      - fsl,imx8qxp-lpcg-dc
+      - fsl,imx8qxp-lpcg-dsp
+      - fsl,imx8qxp-lpcg-gpu
+      - fsl,imx8qxp-lpcg-hsio
+      - fsl,imx8qxp-lpcg-img
+      - fsl,imx8qxp-lpcg-lsio
+      - fsl,imx8qxp-lpcg-vpu
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
+    #include <dt-bindings/clock/imx8-clock.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@5b200000 {
+        compatible = "fsl,imx8qxp-lpcg-conn";
+        reg = <0x5b200000 0xb0000>;
+        #clock-cells = <1>;
+    };
+
+    mmc@5b010000 {
+        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+        interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0x5b010000 0x10000>;
+        clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
+                 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
+                 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
+        clock-names = "ipg", "per", "ahb";
+        power-domains = <&pd IMX_SC_R_SDHC_0>;
+        status = "disabled";
+    };
-- 
2.7.4

