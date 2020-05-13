Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD6C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0176D23129
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgEMAVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:21:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36966 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbgEMAVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:21:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76A7E20117F;
        Wed, 13 May 2020 02:20:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6839B201190;
        Wed, 13 May 2020 02:20:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F391E402BC;
        Wed, 13 May 2020 08:20:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 4/5] dt-bindings: clock: Convert i.MX6SLL clock to json-schema
Date:   Wed, 13 May 2020 08:11:23 +0800
Message-Id: <1589328684-1397-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX6SLL clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since V4:
	- add descriptions for interrupts and each item of it.
---
 .../devicetree/bindings/clock/imx6sll-clock.txt    | 36 ------------
 .../devicetree/bindings/clock/imx6sll-clock.yaml   | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx6sll-clock.txt b/Documentation/devicetree/bindings/clock/imx6sll-clock.txt
deleted file mode 100644
index fee849d..0000000
--- a/Documentation/devicetree/bindings/clock/imx6sll-clock.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Clock bindings for Freescale i.MX6 SLL
-
-Required properties:
-- compatible: Should be "fsl,imx6sll-ccm"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-- clocks: list of clock specifiers, must contain an entry for each required
-  entry in clock-names
-- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sll-clock.h
-for the full list of i.MX6 SLL clock IDs.
-
-Examples:
-
-#include <dt-bindings/clock/imx6sll-clock.h>
-
-clks: clock-controller@20c4000 {
-		compatible = "fsl,imx6sll-ccm";
-		reg = <0x020c4000 0x4000>;
-		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-		#clock-cells = <1>;
-		clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
-		clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
-};
-
-uart1: serial@2020000 {
-		compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart", "fsl,imx21-uart";
-		reg = <0x02020000 0x4000>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX6SLL_CLK_UART1_IPG>,
-			 <&clks IMX6SLL_CLK_UART1_SERIAL>;
-		clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
new file mode 100644
index 0000000..fa55f1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx6sll-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX6 SLL
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx6sll-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: CCM provides 2 interrupt requests, request 1 is to generate
+      interrupt for frequency or mux change, request 2 is to generate
+      interrupt for oscillator read or PLL lock.
+    items:
+      - description: CCM interrupt request 1
+      - description: CCM interrupt request 2
+    maxItems: 2
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: 32k osc
+      - description: 24m osc
+      - description: ipp_di0 clock input
+      - description: ipp_di1 clock input
+
+  clock-names:
+    items:
+      - const: ckil
+      - const: osc
+      - const: ipp_di0
+      - const: ipp_di1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@20c4000 {
+        compatible = "fsl,imx6sll-ccm";
+        reg = <0x020c4000 0x4000>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
+        clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
+    };
-- 
2.7.4

