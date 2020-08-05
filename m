Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2F21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHEGyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:54:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43170 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEGyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:54:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E04062003A2;
        Wed,  5 Aug 2020 08:54:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22B2F2011A3;
        Wed,  5 Aug 2020 08:54:06 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5FEF54024E;
        Wed,  5 Aug 2020 08:54:02 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        o.rempel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: nvmem: Convert snvs lpgpr to json-schema
Date:   Wed,  5 Aug 2020 14:49:32 +0800
Message-Id: <1596610172-30323-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the snvs lpgpr binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       | 21 ---------------
 .../devicetree/bindings/nvmem/snvs-lpgpr.yaml      | 31 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
deleted file mode 100644
index 3cb1708..0000000
--- a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Device tree bindings for Low Power General Purpose Register found in i.MX6Q/D
-and i.MX7 Secure Non-Volatile Storage.
-
-This DT node should be represented as a sub-node of a "syscon",
-"simple-mfd" node.
-
-Required properties:
-- compatible: should be one of the fallowing variants:
-	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S
-	"fsl,imx6ul-snvs-lpgpr" for Freescale i.MX6UL
-	"fsl,imx7d-snvs-lpgpr" for Freescale i.MX7D/S
-
-Example:
-snvs: snvs@020cc000 {
-	compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
-	reg = <0x020cc000 0x4000>;
-
-	snvs_lpgpr: snvs-lpgpr {
-		compatible = "fsl,imx6q-snvs-lpgpr";
-	};
-};
diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.yaml b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.yaml
new file mode 100644
index 0000000..cbc6262
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/snvs-lpgpr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Low Power General Purpose Register found in i.MX Secure Non-Volatile Storage
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6q-snvs-lpgpr
+      - fsl,imx6ul-snvs-lpgpr
+      - fsl,imx7d-snvs-lpgpr
+
+required:
+  - compatible
+
+examples:
+  - |
+    snvs@20cc000 {
+        compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+        reg = <0x20cc000 0x4000>;
+
+        snvs_lpgpr: snvs-lpgpr {
+            compatible = "fsl,imx6q-snvs-lpgpr";
+        };
+    };
-- 
2.7.4

