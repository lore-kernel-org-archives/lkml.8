Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1656EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007A7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE1Hif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgE1Hi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44CA1200A1F;
        Thu, 28 May 2020 09:38:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A833200A16;
        Thu, 28 May 2020 09:38:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 92BDD40305;
        Thu, 28 May 2020 15:38:13 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 6/9] dt-bindings: clock: Convert i.MX27 clock to json-schema
Date:   Thu, 28 May 2020 15:27:56 +0800
Message-Id: <1590650879-18288-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX27 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx27-clock.txt      | 27 -----------
 .../devicetree/bindings/clock/imx27-clock.yaml     | 53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
deleted file mode 100644
index 4c95c04..0000000
--- a/Documentation/devicetree/bindings/clock/imx27-clock.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Clock bindings for Freescale i.MX27
-
-Required properties:
-- compatible: Should be "fsl,imx27-ccm"
-- reg: Address and length of the register set
-- interrupts: Should contain CCM interrupt
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx27-clock.h
-for the full list of i.MX27 clock IDs.
-
-Examples:
-	clks: ccm@10027000{
-		compatible = "fsl,imx27-ccm";
-		reg = <0x10027000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	uart1: serial@1000a000 {
-		compatible = "fsl,imx27-uart", "fsl,imx21-uart";
-		reg = <0x1000a000 0x1000>;
-		interrupts = <20>;
-		clocks = <&clks IMX27_CLK_UART1_IPG_GATE>,
-			 <&clks IMX27_CLK_PER1_GATE>;
-		clock-names = "ipg", "per";
-	};
diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.yaml b/Documentation/devicetree/bindings/clock/imx27-clock.yaml
new file mode 100644
index 0000000..2d69807
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx27-clock.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx27-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX27
+
+maintainers:
+  - Fabio Estevam <fabio.estevam@freescale.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx27-clock.h
+  for the full list of i.MX27 clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imx27-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    #include <dt-bindings/clock/imx27-clock.h>
+
+    clock-controller@10027000 {
+        compatible = "fsl,imx27-ccm";
+        reg = <0x10027000 0x1000>;
+        interrupts = <31>;
+        #clock-cells = <1>;
+    };
+
+    serial@1000a000 {
+        compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+        reg = <0x1000a000 0x1000>;
+        interrupts = <20>;
+        clocks = <&clks IMX27_CLK_UART1_IPG_GATE>,
+                 <&clks IMX27_CLK_PER1_GATE>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

