Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63891C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407DF20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbgDNC4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:56:47 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51914 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404256AbgDNCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:55:35 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2020 19:55:33 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 13 Apr 2020 19:55:30 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 83F01216B6; Tue, 14 Apr 2020 08:25:24 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V3 6/8] dt-bindings: mailbox: Add dt-bindings for ipq6018 apcs global block
Date:   Tue, 14 Apr 2020 08:25:20 +0530
Message-Id: <1586832922-29191-7-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
References: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for ipq6018 mailbox driver

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml         | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index b46474b..07180c0 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -16,6 +16,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - qcom,ipq6018-apcs-apps-global
       - qcom,ipq8074-apcs-apps-global
       - qcom,msm8916-apcs-kpss-global
       - qcom,msm8996-apcs-hmss-global
@@ -36,7 +37,7 @@ properties:
     const: 1
 
   '#clock-cells':
-    const: 0
+    enum: [ 0, 1 ]
 
   clock-names:
     description:
@@ -45,7 +46,7 @@ properties:
     maxItems: 2
     items:
       - const: pll
-      - const: aux
+      - enum: [ aux, xo ]
 
 required:
   - compatible
@@ -86,3 +87,15 @@ examples:
         clock-names = "pll", "aux";
         #clock-cells = <0>;
     };
+
+  # Example apcs with ipq6018
+  - |
+    #include "dt-bindings/clock/qcom,apss-ipq.h"
+    apcs_ipq: mailbox@b111000 {
+        compatible = "qcom,ipq6018-apcs-apps-global";
+        reg = <0x0b111000 0x1000>;
+        #clock-cells = <1>;
+        clocks = <&a53pll>, <&xo>;
+        clock-names = "pll", "xo";
+        #mbox-cells = <1>;
+    };
-- 
2.7.4

