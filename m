Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED79B20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgG3Mru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:47:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54318 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgG3Mrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:47:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D94FE1A1327;
        Thu, 30 Jul 2020 14:47:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C19031A0ED6;
        Thu, 30 Jul 2020 14:47:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F8BF402BF;
        Thu, 30 Jul 2020 14:47:37 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, han.xu@nxp.com, u.kleine-koenig@pengutronix.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] dt-bindings: mtd: Convert imx nand to json-schema
Date:   Thu, 30 Jul 2020 20:43:24 +0800
Message-Id: <1596113004-15548-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
References: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX nand controller binding to DT schema format
using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/mtd/mxc-nand.txt | 19 ----------
 .../devicetree/bindings/mtd/mxc-nand.yaml          | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.txt b/Documentation/devicetree/bindings/mtd/mxc-nand.txt
deleted file mode 100644
index 2857c62..0000000
--- a/Documentation/devicetree/bindings/mtd/mxc-nand.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Freescale's mxc_nand
-
-Required properties:
-- compatible: "fsl,imxXX-nand"
-- reg: address range of the nfc block
-- interrupts: irq to be used
-- nand-bus-width: see nand-controller.yaml
-- nand-ecc-mode: see nand-controller.yaml
-- nand-on-flash-bbt: see nand-controller.yaml
-
-Example:
-
-	nand@d8000000 {
-		compatible = "fsl,imx27-nand";
-		reg = <0xd8000000 0x1000>;
-		interrupts = <29>;
-		nand-bus-width = <8>;
-		nand-ecc-mode = "hw";
-	};
diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
new file mode 100644
index 0000000..ee4d1d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mxc-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Freescale's mxc_nand binding
+
+maintainers:
+  - Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+properties:
+  compatible:
+    const: fsl,imx27-nand
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@d8000000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,imx27-nand";
+        reg = <0xd8000000 0x1000>;
+        interrupts = <29>;
+        nand-bus-width = <8>;
+        nand-ecc-mode = "hw";
+    };
-- 
2.7.4

