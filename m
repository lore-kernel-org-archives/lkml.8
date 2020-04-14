Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7069C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06BC2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbgDNCzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:55:33 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51904 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404222AbgDNCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:55:30 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2020 19:55:29 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 13 Apr 2020 19:55:25 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 23252216A4; Tue, 14 Apr 2020 08:25:24 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V3 2/8] dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
Date:   Tue, 14 Apr 2020 08:25:16 +0530
Message-Id: <1586832922-29191-3-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
References: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds schema for primary CPU PLL found on few Qualcomm
platforms.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
[V3]
 * Fixed dt binding error in "$id" field.

 .../devicetree/bindings/clock/qcom,a53pll.txt      | 22 --------
 .../devicetree/bindings/clock/qcom,a53pll.yaml     | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.txt b/Documentation/devicetree/bindings/clock/qcom,a53pll.txt
deleted file mode 100644
index e3fa811..0000000
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Qualcomm MSM8916 A53 PLL Binding
---------------------------------
-The A53 PLL on MSM8916 platforms is the main CPU PLL used used for frequencies
-above 1GHz.
-
-Required properties :
-- compatible : Shall contain only one of the following:
-
-		"qcom,msm8916-a53pll"
-
-- reg : shall contain base register location and length
-
-- #clock-cells : must be set to <0>
-
-Example:
-
-	a53pll: clock@b016000 {
-		compatible = "qcom,msm8916-a53pll";
-		reg = <0xb016000 0x40>;
-		#clock-cells = <0>;
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
new file mode 100644
index 0000000..c865293
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,a53pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm A53 PLL Binding
+
+maintainers:
+  - Sivaprakash Murugesan <sivaprak@codeaurora.org>
+
+description:
+  The A53 PLL on few Qualcomm platforms is the main CPU PLL used used for
+  frequencies above 1GHz.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8916-a53pll
+      - qcom,ipq6018-a53pll
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    description: clocks required for this controller.
+    maxItems: 1
+
+  clock-names:
+    description: clock output names of required clocks.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  #Example 1 - A53 PLL found on MSM8916 devices
+  - |
+    a53pll: clock@b016000 {
+        compatible = "qcom,msm8916-a53pll";
+        reg = <0xb016000 0x40>;
+        #clock-cells = <0>;
+    };
+
+  #Example 2 - A53 PLL found on IPQ6018 devices
+  - |
+    a53pll_ipq: clock@b116000 {
+        compatible = "qcom,ipq6018-a53pll";
+        reg = <0x0b116000 0x40>;
+        #clock-cells = <0>;
+        clocks = <&xo>;
+        clock-names = "xo";
+    };
-- 
2.7.4

