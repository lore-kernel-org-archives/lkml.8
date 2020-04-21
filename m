Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6BC55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680352071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDUOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:18:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43102 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgDUOSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:18:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 51B8E1A0D8B;
        Tue, 21 Apr 2020 16:18:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 208891A0D94;
        Tue, 21 Apr 2020 16:18:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BD112402E8;
        Tue, 21 Apr 2020 22:17:58 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/3] dt-bindings: nvmem: Convert i.MX IIM to json-schema
Date:   Tue, 21 Apr 2020 22:09:40 +0800
Message-Id: <1587478181-21226-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
References: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX IIM binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- drop clocks description.
---
 .../devicetree/bindings/nvmem/imx-iim.txt          | 22 ---------
 .../devicetree/bindings/nvmem/imx-iim.yaml         | 57 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)
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
index 0000000..9cc43e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
@@ -0,0 +1,57 @@
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

