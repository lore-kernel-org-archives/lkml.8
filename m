Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D332C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBF820769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgEMAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:21:00 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56432 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbgEMAU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:20:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 100DC1A12A6;
        Wed, 13 May 2020 02:20:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBF821A124D;
        Wed, 13 May 2020 02:20:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F898402B4;
        Wed, 13 May 2020 08:20:45 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 2/5] dt-bindings: clock: Convert i.MX6SX clock to json-schema
Date:   Wed, 13 May 2020 08:11:21 +0800
Message-Id: <1589328684-1397-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX6SX clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since V4:
	- add descriptions for interrupts and each item of it.
---
 .../devicetree/bindings/clock/imx6sx-clock.txt     | 13 ----
 .../devicetree/bindings/clock/imx6sx-clock.yaml    | 70 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.txt b/Documentation/devicetree/bindings/clock/imx6sx-clock.txt
deleted file mode 100644
index 22362b9..0000000
--- a/Documentation/devicetree/bindings/clock/imx6sx-clock.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* Clock bindings for Freescale i.MX6 SoloX
-
-Required properties:
-- compatible: Should be "fsl,imx6sx-ccm"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-- clocks: list of clock specifiers, must contain an entry for each required
-  entry in clock-names
-- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sx-clock.h
-for the full list of i.MX6 SoloX clock IDs.
diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
new file mode 100644
index 0000000..982d698
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx6sx-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX6 SoloX
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx6sx-ccm
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
+      - description: anaclk1 clock input
+      - description: anaclk2 clock input
+
+  clock-names:
+    items:
+      - const: ckil
+      - const: osc
+      - const: ipp_di0
+      - const: ipp_di1
+      - const: anaclk1
+      - const: anaclk2
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
+        compatible = "fsl,imx6sx-ccm";
+        reg = <0x020c4000 0x4000>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>, <&anaclk1>, <&anaclk2>;
+        clock-names = "ckil", "osc", "ipp_di0", "ipp_di1", "anaclk1", "anaclk2";
+    };
-- 
2.7.4

