Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF1BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D7A208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgE1Hij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39412 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgE1Hie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4960200A25;
        Thu, 28 May 2020 09:38:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C4DF200A1D;
        Thu, 28 May 2020 09:38:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EBB1F402D3;
        Thu, 28 May 2020 15:38:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 9/9] dt-bindings: clock: Convert i.MX1 clock to json-schema
Date:   Thu, 28 May 2020 15:27:59 +0800
Message-Id: <1590650879-18288-10-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX1 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx1-clock.txt       | 26 ------------
 .../devicetree/bindings/clock/imx1-clock.yaml      | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.txt b/Documentation/devicetree/bindings/clock/imx1-clock.txt
deleted file mode 100644
index 9823baf..0000000
--- a/Documentation/devicetree/bindings/clock/imx1-clock.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Clock bindings for Freescale i.MX1 CPUs
-
-Required properties:
-- compatible: Should be "fsl,imx1-ccm".
-- reg: Address and length of the register set.
-- #clock-cells: Should be <1>.
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx1-clock.h
-for the full list of i.MX1 clock IDs.
-
-Examples:
-	clks: ccm@21b000 {
-		#clock-cells = <1>;
-		compatible = "fsl,imx1-ccm";
-		reg = <0x0021b000 0x1000>;
-	};
-
-	pwm: pwm@208000 {
-		#pwm-cells = <2>;
-		compatible = "fsl,imx1-pwm";
-		reg = <0x00208000 0x1000>;
-		interrupts = <34>;
-		clocks = <&clks IMX1_CLK_DUMMY>, <&clks IMX1_CLK_PER1>;
-		clock-names = "ipg", "per";
-	};
diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.yaml b/Documentation/devicetree/bindings/clock/imx1-clock.yaml
new file mode 100644
index 0000000..06a0ff9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx1-clock.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx1-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX1 CPUs
+
+maintainers:
+  - Alexander Shiyan <shc_work@mail.ru>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx1-clock.h
+  for the full list of i.MX1 clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imx1-ccm
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
+    #include <dt-bindings/clock/imx1-clock.h>
+
+    clock-controller@21b000 {
+        #clock-cells = <1>;
+        compatible = "fsl,imx1-ccm";
+        reg = <0x0021b000 0x1000>;
+    };
+
+    pwm@208000 {
+        #pwm-cells = <2>;
+        compatible = "fsl,imx1-pwm";
+        reg = <0x00208000 0x1000>;
+        interrupts = <34>;
+        clocks = <&clks IMX1_CLK_DUMMY>, <&clks IMX1_CLK_PER1>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

