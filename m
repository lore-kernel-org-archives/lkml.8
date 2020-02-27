Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538CC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B759A222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgB0Jza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:55:30 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38118 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbgB0Jz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:55:28 -0500
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Feb 2020 01:55:27 -0800
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 27 Feb 2020 01:55:24 -0800
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 99122210E9; Thu, 27 Feb 2020 15:25:22 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sivaprak@codeaurora.org
Subject: [PATCH 1/2] clk: qcom: Add DT bindings for ipq6018 apss clock controller
Date:   Thu, 27 Feb 2020 15:25:17 +0530
Message-Id: <1582797318-26288-2-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582797318-26288-1-git-send-email-sivaprak@codeaurora.org>
References: <1582797318-26288-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add dt-binding for ipq6018 apss clock controller

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,apsscc.yaml     | 58 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq6018.h      | 26 ++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,apsscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq6018.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,apsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,apsscc.yaml
new file mode 100644
index 0000000..7433721
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,apsscc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,apsscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 APSS Clock Controller Binding
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  Qualcomm IPQ6018 APSS clock control module which supports the clocks with
+  frequencies above 800Mhz.
+
+properties:
+  compatible :
+    const: qcom,apss-ipq6018
+
+  clocks:
+    description: clocks required for this controller.
+    maxItems: 4
+
+  clock-names:
+    description: clock output names of required clocks.
+    maxItems: 4
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+      apss_clk: qcom,apss_clk@b111000 {
+            compatible = "qcom,apss-ipq6018";
+            clocks = <&xo>, <&gcc GPLL0>,
+                        <&gcc GPLL2>, <&gcc GPLL4>;
+            clock-names = "xo", "gpll0",
+                         "gpll2", "gpll4";
+            reg = <0xb11100c 0x5ff4>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+      };
+...
diff --git a/include/dt-bindings/clock/qcom,apss-ipq6018.h b/include/dt-bindings/clock/qcom,apss-ipq6018.h
new file mode 100644
index 0000000..ed9d7d8
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,apss-ipq6018.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ6018_H
+#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ6018_H
+
+#define APSS_PLL_EARLY				0
+#define APSS_PLL				1
+#define APCS_ALIAS0_CLK_SRC			2
+#define APCS_ALIAS0_CORE_CLK			3
+
+#endif
-- 
2.7.4

