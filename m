Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E18C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83632065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgENLuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:50:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35176 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:50:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E9E91A0300;
        Thu, 14 May 2020 13:50:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8992A1A02D1;
        Thu, 14 May 2020 13:50:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CCD540245;
        Thu, 14 May 2020 19:50:32 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Date:   Thu, 14 May 2020 19:41:10 +0800
Message-Id: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mxs pwm binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt  | 17 ---------
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
deleted file mode 100644
index a1b8a48..0000000
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Freescale MXS PWM controller
-
-Required properties:
-- compatible: should be "fsl,imx23-pwm"
-- reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-- fsl,pwm-number: the number of PWM devices
-
-Example:
-
-pwm: pwm@80064000 {
-	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
-	reg = <0x80064000 0x2000>;
-	#pwm-cells = <3>;
-	fsl,pwm-number = <8>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
new file mode 100644
index 0000000..da68f4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/mxs-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS PWM controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+  - Anson Huang <anson.huang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  fsl,pwm-number:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the number of PWM devices
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - fsl,pwm-number
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@80064000 {
+        compatible = "fsl,imx23-pwm";
+        reg = <0x80064000 0x2000>;
+        #pwm-cells = <3>;
+        fsl,pwm-number = <8>;
+    };
-- 
2.7.4

