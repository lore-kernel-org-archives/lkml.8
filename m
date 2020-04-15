Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1DDC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D0E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbgDODlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:41:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36994 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388436AbgDODlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:41:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E74E20071C;
        Wed, 15 Apr 2020 05:41:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2651200716;
        Wed, 15 Apr 2020 05:41:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D38840307;
        Wed, 15 Apr 2020 11:41:24 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: nvmem: Convert MXS OCOTP to json-schema
Date:   Wed, 15 Apr 2020 11:33:22 +0800
Message-Id: <1586921602-1877-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
References: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MXS OCOTP binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        | 24 ----------
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       | 52 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
deleted file mode 100644
index 372c72f..0000000
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-On-Chip OTP Memory for Freescale i.MX23/i.MX28
-
-Required properties :
-- compatible :
-  - "fsl,imx23-ocotp" for i.MX23
-  - "fsl,imx28-ocotp" for i.MX28
-- #address-cells : Should be 1
-- #size-cells : Should be 1
-- reg : Address and length of OTP controller registers
-- clocks : Should contain a reference to the hbus clock
-
-= Data cells =
-Are child nodes of mxs-ocotp, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example for i.MX28:
-
-	ocotp: ocotp@8002c000 {
-		compatible = "fsl,imx28-ocotp", "fsl,ocotp";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x8002c000 0x2000>;
-		clocks = <&clks 25>;
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
new file mode 100644
index 0000000..b8be3bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mxs-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: On-Chip OTP Memory for Freescale i.MX23/i.MX28
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-ocotp
+      - fsl,imx28-ocotp
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: |
+      OCOTP's clock source.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    ocotp: efuse@8002c000 {
+        compatible = "fsl,imx28-ocotp";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x8002c000 0x2000>;
+        clocks = <&clks 25>;
+    };
+
+...
-- 
2.7.4

