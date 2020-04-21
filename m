Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F464C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BEB206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgDUOSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:18:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43134 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgDUOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:18:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 321F01A0D8A;
        Tue, 21 Apr 2020 16:18:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 021231A0DA4;
        Tue, 21 Apr 2020 16:18:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9E149402ED;
        Tue, 21 Apr 2020 22:17:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/3] dt-bindings: nvmem: Convert MXS OCOTP to json-schema
Date:   Tue, 21 Apr 2020 22:09:41 +0800
Message-Id: <1587478181-21226-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
References: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MXS OCOTP binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- drop clocks description.
---
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        | 24 -----------
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       | 50 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 24 deletions(-)
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
index 0000000..ff317fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -0,0 +1,50 @@
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

