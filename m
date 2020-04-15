Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C33B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbgDODlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:41:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52542 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388437AbgDODlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:41:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 10E401A06AE;
        Wed, 15 Apr 2020 05:41:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2A1E1A06B1;
        Wed, 15 Apr 2020 05:41:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 685A0402FC;
        Wed, 15 Apr 2020 11:41:23 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] dt-bindings: nvmem: Convert i.MX IIM to json-schema
Date:   Wed, 15 Apr 2020 11:33:21 +0800
Message-Id: <1586921602-1877-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
References: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX IIM binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/nvmem/imx-iim.txt          | 22 --------
 .../devicetree/bindings/nvmem/imx-iim.yaml         | 59 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.txt b/Documentation/devicetree/bindings/nvmem/imx-iim.txt
deleted file mode 100644
index 1978c5b..0000000
--- a/Documentation/devicetree/bindings/nvmem/imx-iim.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Freescale i.MX IC Identification Module (IIM) device tree bindings
-
-This binding represents the IC Identification Module (IIM) found on
-i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
-
-Required properties:
-- compatible: should be one of
-	"fsl,imx25-iim", "fsl,imx27-iim",
-	"fsl,imx31-iim", "fsl,imx35-iim",
-	"fsl,imx51-iim", "fsl,imx53-iim",
-- reg: Should contain the register base and length.
-- interrupts: Should contain the interrupt for the IIM
-- clocks: Should contain a phandle pointing to the gated peripheral clock.
-
-Example:
-
-	iim: iim@63f98000 {
-		compatible = "fsl,imx53-iim", "fsl,imx27-iim";
-		reg = <0x63f98000 0x4000>;
-		interrupts = <69>;
-                clocks = <&clks IMX5_CLK_IIM_GATE>;
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
new file mode 100644
index 0000000..0d85d37
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX IC Identification Module (IIM) device tree bindings
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+description: |
+  This binding represents the IC Identification Module (IIM) found on
+  i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx25-iim
+      - fsl,imx27-iim
+      - fsl,imx31-iim
+      - fsl,imx35-iim
+      - fsl,imx51-iim
+      - fsl,imx53-iim
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: |
+      IIM's clock source.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
+    iim: efuse@63f98000 {
+        compatible = "fsl,imx53-iim";
+        reg = <0x63f98000 0x4000>;
+        interrupts = <69>;
+        clocks = <&clks IMX5_CLK_IIM_GATE>;
+    };
+
+...
-- 
2.7.4

