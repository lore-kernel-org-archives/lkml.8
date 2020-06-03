Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29E720678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgFCGYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:24:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54202 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgFCGYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:24:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14A571A0F6F;
        Wed,  3 Jun 2020 08:24:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02B271A00B2;
        Wed,  3 Jun 2020 08:23:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A8D28402E8;
        Wed,  3 Jun 2020 14:23:50 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        marex@denx.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: spi: Convert imx lpspi to json-schema
Date:   Wed,  3 Jun 2020 14:13:29 +0800
Message-Id: <1591164809-13964-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
References: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX LPSPI binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      | 29 -----------
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
deleted file mode 100644
index e71b81a..0000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Freescale Low Power SPI (LPSPI) for i.MX
-
-Required properties:
-- compatible :
-  - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
-  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
-- reg : address and length of the lpspi master registers
-- interrupt-parent : core interrupt controller
-- interrupts : lpspi interrupt
-- clocks : lpspi clock specifier. Its number and order need to correspond to the
-	   value in clock-names.
-- clock-names : Corresponding to per clock and ipg clock in "clocks"
-		respectively. In i.MX7ULP, it only has per clk, so use CLK_DUMMY
-		to fill the "ipg" blank.
-- spi-slave : spi slave mode support. In slave mode, add this attribute without
-	      value. In master mode, remove it.
-
-Examples:
-
-lpspi2: lpspi@40290000 {
-	compatible = "fsl,imx7ulp-spi";
-	reg = <0x40290000 0x10000>;
-	interrupt-parent = <&intc>;
-	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX7ULP_CLK_LPSPI2>,
-		 <&clks IMX7ULP_CLK_DUMMY>;
-	clock-names = "per", "ipg";
-	spi-slave;
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
new file mode 100644
index 0000000..d18e2b0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-fsl-lpspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Low Power SPI (LPSPI) for i.MX
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-spi
+      - fsl,imx8qxp-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC SPI per clock
+      - description: SoC SPI ipg clock
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: per
+      - const: ipg
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@40290000 {
+        compatible = "fsl,imx7ulp-spi";
+        reg = <0x40290000 0x10000>;
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX7ULP_CLK_LPSPI2>,
+                 <&clks IMX7ULP_CLK_DUMMY>;
+        clock-names = "per", "ipg";
+        spi-slave;
+    };
-- 
2.7.4

