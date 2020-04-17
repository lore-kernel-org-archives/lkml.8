Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0099C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C9D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgDQAtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:49:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54530 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgDQAtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:49:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59C48200F1E;
        Fri, 17 Apr 2020 02:49:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CDEF200F13;
        Fri, 17 Apr 2020 02:49:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 915DD40246;
        Fri, 17 Apr 2020 08:49:37 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/5] dt-bindings: clock: Convert i.MX6SL clock to json-schema
Date:   Fri, 17 Apr 2020 08:41:29 +0800
Message-Id: <1587084091-5941-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
References: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX6SL clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- Force 'interrupts' minItem/maxItem to 2.
---
 .../devicetree/bindings/clock/imx6sl-clock.txt     | 10 -----
 .../devicetree/bindings/clock/imx6sl-clock.yaml    | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.txt b/Documentation/devicetree/bindings/clock/imx6sl-clock.txt
deleted file mode 100644
index 15e40bd..0000000
--- a/Documentation/devicetree/bindings/clock/imx6sl-clock.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-* Clock bindings for Freescale i.MX6 SoloLite
-
-Required properties:
-- compatible: Should be "fsl,imx6sl-ccm"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sl-clock.h
-for the full list of i.MX6 SoloLite clock IDs.
diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
new file mode 100644
index 0000000..f78ee4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx6sl-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX6 SoloLite
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx6sl-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clks: clock-controller@20c4000 {
+        compatible = "fsl,imx6sl-ccm";
+        reg = <0x020c4000 0x4000>;
+        interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+    };
-- 
2.7.4

