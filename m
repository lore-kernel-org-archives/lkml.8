Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE82C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C713C20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFKJsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:48:43 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:19527 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgFKJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:48:42 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Jun 2020 15:18:26 +0530
Received: from c-rbokka-linux.qualcomm.com ([10.206.232.238])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Jun 2020 15:18:05 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id 080AE2CBF; Thu, 11 Jun 2020 15:18:04 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
Date:   Thu, 11 Jun 2020 15:18:00 +0530
Message-Id: <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt-bindings document for qfprom-efuse controller.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
---
 .../devicetree/bindings/nvmem/qfprom.yaml          | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
new file mode 100644
index 0000000..7c8fc31
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qfprom.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, QFPROM Efuse bindings
+
+maintainers:
+  - Ravi Kumar Bokka <rbokka@codeaurora.org>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,qfprom
+
+  reg:
+    maxItems: 3
+
+required:
+   - compatible
+   - reg
+   - reg-names
+   - clocks
+   - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+    qfprom@780000 {
+	compatible = "qcom,qfprom";
+	reg = <0 0x00780000 0 0x7a0>,
+	      <0 0x00782000 0 0x100>,
+	      <0 0x00784000 0 0x8ff>;
+	reg-names = "raw", "conf", "corrected";
+	clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
+	clock-names = "secclk";
+
+	qusb2p_hstx_trim: hstx-trim-primary@25b {
+		reg = <0x25b 0x1>;
+		bits = <1 3>;
+	};
+    };
+
+    &qfprom {
+        vcc-supply = <&vreg_l11a_1p8>;
+    };
+
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

