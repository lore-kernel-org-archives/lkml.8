Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD028C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D0B2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHECnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:43:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46114 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHECnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:43:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E9851A149A;
        Wed,  5 Aug 2020 04:43:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 44CA31A149B;
        Wed,  5 Aug 2020 04:42:46 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 583D5402CF;
        Wed,  5 Aug 2020 04:42:40 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     zbr@ioremap.net, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mfuzzey@parkeon.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: w1: Convert i.MX to json-schema
Date:   Wed,  5 Aug 2020 10:38:11 +0800
Message-Id: <1596595091-26760-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX one wire binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/w1/fsl-imx-owire.txt       | 18 ----------
 .../devicetree/bindings/w1/fsl-imx-owire.yaml      | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
 create mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml

diff --git a/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt b/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
deleted file mode 100644
index cbaa646..0000000
--- a/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Freescale i.MX One wire bus master controller
-
-Required properties:
-- compatible : should be "fsl,imx21-owire"
-- reg : Address and length of the register set for the device
-
-Optional properties:
-- clocks : phandle of clock that supplies the module (required if platform
-		clock bindings use device tree)
-
-Example:
-
-- From imx53.dtsi:
-owire: owire@63fa4000 {
-	compatible = "fsl,imx53-owire", "fsl,imx21-owire";
-	reg = <0x63fa4000 0x4000>;
-	clocks = <&clks 159>;
-};
diff --git a/Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml b/Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml
new file mode 100644
index 0000000..67681fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/fsl-imx-owire.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX One wire bus master controller
+
+maintainers:
+  - Martin Fuzzey <mfuzzey@parkeon.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx21-owire
+      - items:
+          - enum:
+            - fsl,imx27-owire
+            - fsl,imx50-owire
+            - fsl,imx51-owire
+            - fsl,imx53-owire
+          - const: fsl,imx21-owire
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
+    owire@63fa4000 {
+        compatible = "fsl,imx53-owire", "fsl,imx21-owire";
+        reg = <0x63fa4000 0x4000>;
+        clocks = <&clks IMX5_CLK_OWIRE_GATE>;
+    };
-- 
2.7.4

