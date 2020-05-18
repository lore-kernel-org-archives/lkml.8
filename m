Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F632065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgERO5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:57:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53308 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgERO53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC6DA2009BA;
        Mon, 18 May 2020 16:57:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74FAE2009CA;
        Mon, 18 May 2020 16:57:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A298402AD;
        Mon, 18 May 2020 22:57:14 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] dt-bindings: timer: Convert i.MX GPT to json-schema
Date:   Mon, 18 May 2020 22:47:38 +0800
Message-Id: <1589813260-20036-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX GPT binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt       |  45 ---------
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 109 +++++++++++++++++++++
 2 files changed, 109 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
deleted file mode 100644
index 5d8fd5b..0000000
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Freescale i.MX General Purpose Timer (GPT)
-
-Required properties:
-
-- compatible : should be one of following:
-  for i.MX1:
-  - "fsl,imx1-gpt";
-  for i.MX21:
-  - "fsl,imx21-gpt";
-  for i.MX27:
-  - "fsl,imx27-gpt", "fsl,imx21-gpt";
-  for i.MX31:
-  - "fsl,imx31-gpt";
-  for i.MX25:
-  - "fsl,imx25-gpt", "fsl,imx31-gpt";
-  for i.MX50:
-  - "fsl,imx50-gpt", "fsl,imx31-gpt";
-  for i.MX51:
-  - "fsl,imx51-gpt", "fsl,imx31-gpt";
-  for i.MX53:
-  - "fsl,imx53-gpt", "fsl,imx31-gpt";
-  for i.MX6Q:
-  - "fsl,imx6q-gpt", "fsl,imx31-gpt";
-  for i.MX6DL:
-  - "fsl,imx6dl-gpt";
-  for i.MX6SL:
-  - "fsl,imx6sl-gpt", "fsl,imx6dl-gpt";
-  for i.MX6SX:
-  - "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
-- reg : specifies base physical address and size of the registers.
-- interrupts : should be the gpt interrupt.
-- clocks : the clocks provided by the SoC to drive the timer, must contain
-           an entry for each entry in clock-names.
-- clock-names : must include "ipg" entry first, then "per" entry.
-
-Example:
-
-gpt1: timer@10003000 {
-	compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
-	reg = <0x10003000 0x1000>;
-	interrupts = <26>;
-	clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
-		 <&clks IMX27_CLK_PER1_GATE>;
-	clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
new file mode 100644
index 0000000..5c7186b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,imxgpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX General Purpose Timer (GPT)
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    oneOf:
+      - description: on i.MX1 the following compatible must be specified
+        items:
+          - const: "fsl,imx1-gpt"
+
+      - description: on i.MX21 the following compatible must be specified
+        items:
+          - const: "fsl,imx21-gpt"
+
+      - description: on i.MX27 the following compatibles must be specified
+        items:
+          - const: "fsl,imx27-gpt"
+          - const: "fsl,imx21-gpt"
+
+      - description: on i.MX31 the following compatible must be specified
+        items:
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX25 the following compatibles must be specified
+        items:
+          - const: "fsl,imx25-gpt"
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX50 the following compatibles must be specified
+        items:
+          - const: "fsl,imx50-gpt"
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX51 the following compatibles must be specified
+        items:
+          - const: "fsl,imx51-gpt"
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX53 the following compatibles must be specified
+        items:
+          - const: "fsl,imx53-gpt"
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX6Q the following compatibles must be specified
+        items:
+          - const: "fsl,imx6q-gpt"
+          - const: "fsl,imx31-gpt"
+
+      - description: on i.MX6DL the following compatible must be specified
+        items:
+          - const: "fsl,imx6dl-gpt"
+
+      - description: on i.MX6SL the following compatibles must be specified
+        items:
+          - const: "fsl,imx6sl-gpt"
+          - const: "fsl,imx6dl-gpt"
+
+      - description: on i.MX6SX the following compatibles must be specified
+        items:
+          - const: "fsl,imx6sx-gpt"
+          - const: "fsl,imx6dl-gpt"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC GPT ipg clock
+      - description: SoC GPT per clock
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx27-clock.h>
+
+    timer@10003000 {
+        compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
+        reg = <0x10003000 0x1000>;
+        interrupts = <26>;
+        clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
+                 <&clks IMX27_CLK_PER1_GATE>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

