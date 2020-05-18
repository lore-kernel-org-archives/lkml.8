Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA8620756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgERO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:57:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56316 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgERO53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AF6D1A0B12;
        Mon, 18 May 2020 16:57:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F17E1A0B14;
        Mon, 18 May 2020 16:57:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D0E09402AF;
        Mon, 18 May 2020 22:57:15 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] dt-bindings: timer: Convert i.MX TPM to json-schema
Date:   Mon, 18 May 2020 22:47:39 +0800
Message-Id: <1589813260-20036-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX TPM binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    | 28 ----------
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
deleted file mode 100644
index f82087b..0000000
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-NXP Low Power Timer/Pulse Width Modulation Module (TPM)
-
-The Timer/PWM Module (TPM) supports input capture, output compare,
-and the generation of PWM signals to control electric motor and power
-management applications. The counter, compare and capture registers
-are clocked by an asynchronous clock that can remain enabled in low
-power modes. TPM can support global counter bus where one TPM drives
-the counter bus for the others, provided bit width is the same.
-
-Required properties:
-
-- compatible :	should be "fsl,imx7ulp-tpm"
-- reg :		Specifies base physical address and size of the register sets
-		for the clock event device and clock source device.
-- interrupts :	Should be the clock event device interrupt.
-- clocks :	The clocks provided by the SoC to drive the timer, must contain
-		an entry for each entry in clock-names.
-- clock-names : Must include the following entries: "ipg" and "per".
-
-Example:
-tpm5: tpm@40260000 {
-	compatible = "fsl,imx7ulp-tpm";
-	reg = <0x40260000 0x1000>;
-	interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
-		 <&clks IMX7ULP_CLK_LPTPM5>;
-	clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
new file mode 100644
index 0000000..0d34610
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nxp,tpm-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Low Power Timer/Pulse Width Modulation Module (TPM)
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: |
+  The Timer/PWM Module (TPM) supports input capture, output compare,
+  and the generation of PWM signals to control electric motor and power
+  management applications. The counter, compare and capture registers
+  are clocked by an asynchronous clock that can remain enabled in low
+  power modes. TPM can support global counter bus where one TPM drives
+  the counter bus for the others, provided bit width is the same.
+
+properties:
+  compatible:
+    const: fsl,imx7ulp-tpm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC TPM ipg clock
+      - description: SoC TPM per clock
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
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@40260000 {
+        compatible = "fsl,imx7ulp-tpm";
+        reg = <0x40260000 0x1000>;
+        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+                 <&pcc2 IMX7ULP_CLK_LPTPM5>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

