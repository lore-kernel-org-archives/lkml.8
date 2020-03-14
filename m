Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89855C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E24206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Xkvqu7T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCOBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:48:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27566 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgCOBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:48:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584236906; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=JylJ2rTy/Spa9FGV/rDNvZeuTPw7s+H4qdIzU9nL+wo=; b=Xkvqu7T9Qg40/sRNAlRtV49KFMogIHwKlu6HlJlzgNgGHEWWNXvtXjAEUpwRwkFjd/Fdy1P2
 On0sUDxEmaoXYCeLX6EXoJ4sH4n+DibhWsHQQ7ByX/fv5t8yD49fR+8cBn4O8VW2evbCXQS7
 icSt/MsiUpvtmmnWDKpP9IrF/dY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6d24e1.7f4eca242148-smtp-out-n04;
 Sat, 14 Mar 2020 18:39:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C92AFC43637; Sat, 14 Mar 2020 18:39:27 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D1C9C433CB;
        Sat, 14 Mar 2020 18:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D1C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v6 1/3] dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
Date:   Sun, 15 Mar 2020 00:09:05 +0530
Message-Id: <1584211147-5570-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584211147-5570-1-git-send-email-tdas@codeaurora.org>
References: <1584211147-5570-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Modem Subsystem clock provider have a bunch of generic properties
that are needed in a device tree. Add a YAML schemas for those.

Add clock ids for GCC MSS and MSS clocks which are required to bring
the modem out of reset.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml | 62 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |  7 ++-
 include/dt-bindings/clock/qcom,mss-sc7180.h        | 12 +++++
 3 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
 create mode 100644 include/dt-bindings/clock/qcom,mss-sc7180.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
new file mode 100644
index 0000000..72493dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,sc7180-mss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Modem Clock Controller Binding
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm modem clock control module which supports the clocks.
+
+  See also dt-bindings/clock/qcom,mss-sc7180.h.
+
+properties:
+  compatible:
+    enum:
+       - qcom,sc7180-mss
+
+  clocks:
+    items:
+      - description: gcc_mss_mfab_axi clock from GCC
+      - description: gcc_mss_nav_axi clock from GCC
+      - description: gcc_mss_cfg_ahb clock from GCC
+
+  clock-names:
+    items:
+      - const: gcc_mss_mfab_axis
+      - const: gcc_mss_nav_axi
+      - const: cfg_ahb
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    clock-controller@41a8000 {
+      compatible = "qcom,sc7180-mss";
+      reg = <0 0x041a8000 0 0x8000>;
+      clocks = <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+               <&gcc GCC_MSS_NAV_AXI_CLK>,
+               <&gcc GCC_MSS_CFG_AHB_CLK>;
+      clock-names = "gcc_mss_mfab_axis",
+                    "gcc_mss_nav_axi",
+                    "cfg_ahb";
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gcc-sc7180.h b/include/dt-bindings/clock/qcom,gcc-sc7180.h
index e8029b2e..1258fd0 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc7180.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc7180.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_CLK_QCOM_GCC_SC7180_H
@@ -132,6 +132,11 @@
 #define GCC_VIDEO_GPLL0_DIV_CLK_SRC				122
 #define GCC_VIDEO_THROTTLE_AXI_CLK				123
 #define GCC_VIDEO_XO_CLK					124
+#define GCC_MSS_CFG_AHB_CLK					125
+#define GCC_MSS_MFAB_AXIS_CLK					126
+#define GCC_MSS_NAV_AXI_CLK					127
+#define GCC_MSS_Q6_MEMNOC_AXI_CLK				128
+#define GCC_MSS_SNOC_AXI_CLK					129
 
 /* GCC resets */
 #define GCC_QUSB2PHY_PRIM_BCR					0
diff --git a/include/dt-bindings/clock/qcom,mss-sc7180.h b/include/dt-bindings/clock/qcom,mss-sc7180.h
new file mode 100644
index 0000000..f15a9de
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mss-sc7180.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_MSS_SC7180_H
+#define _DT_BINDINGS_CLK_QCOM_MSS_SC7180_H
+
+#define MSS_AXI_CRYPTO_CLK	0
+#define MSS_AXI_NAV_CLK		1
+
+#endif
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
