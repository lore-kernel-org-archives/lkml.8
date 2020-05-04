Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2700C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5C20735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEDGa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 02:30:58 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:52224 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgEDGa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 02:30:57 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2020 23:30:31 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 03 May 2020 23:30:29 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 5BDE92168F; Mon,  4 May 2020 12:00:27 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH] dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
Date:   Mon,  4 May 2020 12:00:03 +0530
Message-Id: <1588573803-3823-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds schema for primary CPU PLL found on few Qualcomm
platforms.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,a53pll.txt      | 22 ------------
 .../devicetree/bindings/clock/qcom,a53pll.yaml     | 40 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 22 deletions(-)
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
index 0000000..20d2638
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -0,0 +1,40 @@
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
+    const: qcom,msm8916-a53pll
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
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
-- 
2.7.4

