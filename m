Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89482C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767B3208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHECz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:55:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46422 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHECzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:55:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F9DF2013A5;
        Wed,  5 Aug 2020 04:55:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43E6B20139E;
        Wed,  5 Aug 2020 04:55:16 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C0295402E5;
        Wed,  5 Aug 2020 04:55:10 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] dt-bindings: fsl: Convert i.MX7ULP SIM to json-schema
Date:   Wed,  5 Aug 2020 10:50:41 +0800
Message-Id: <1596595841-27563-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
References: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX7ULP SIM binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/arm/freescale/fsl,imx7ulp-sim.txt     | 16 ----------
 .../bindings/arm/freescale/fsl,imx7ulp-sim.yaml    | 36 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
deleted file mode 100644
index 7d0c7f0..0000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Freescale i.MX7ULP System Integration Module
-----------------------------------------------
-The system integration module (SIM) provides system control and chip configuration
-registers. In this module, chip revision information is located in JTAG ID register,
-and a set of registers have been made available in DGO domain for SW use, with the
-objective to maintain its value between system resets.
-
-Required properties:
-- compatible:	Should be "fsl,imx7ulp-sim".
-- reg:		Specifies base physical address and size of the register sets.
-
-Example:
-sim: sim@410a3000 {
-	compatible = "fsl,imx7ulp-sim", "syscon";
-	reg = <0x410a3000 0x1000>;
-};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml
new file mode 100644
index 0000000..8b4aff6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,imx7ulp-sim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX7ULP System Integration Module
+
+maintainers:
+  - Anson Huang <anson.huang@nxp.com>
+
+description: |
+  The system integration module (SIM) provides system control and chip configuration
+  registers. In this module, chip revision information is located in JTAG ID register,
+  and a set of registers have been made available in DGO domain for SW use, with the
+  objective to maintain its value between system resets.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx7ulp-sim
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    sim@410a3000 {
+        compatible = "fsl,imx7ulp-sim", "syscon";
+        reg = <0x410a3000 0x1000>;
+    };
-- 
2.7.4

