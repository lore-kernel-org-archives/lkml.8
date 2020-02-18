Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669724125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tC5YVY8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBRSQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:16:14 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:33173 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbgBRSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:16:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582049774; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7Wou56nRaSS3Oohh4m35/UOnaSBOM5e/GX2u30NcQWI=; b=tC5YVY8/VblUq5bo3BnLsDmuelilvE0ND6gSiiAtsJPEgQnGywe4LYy4cXFxMK92tiySDxe3
 rTwnEYWsLUJMT3veqCPt7HQokwTOglEdGno2oCa7nRLPSVQbUfl4Eioh0cXUItJvHeH+v2j6
 QKz+YytBatpSa+YKOJSRwcdzNSc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4c29e5.7f6368591298-smtp-out-n03;
 Tue, 18 Feb 2020 18:16:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A800C447A4; Tue, 18 Feb 2020 18:16:05 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0143C447A0;
        Tue, 18 Feb 2020 18:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0143C447A0
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
Subject: [PATCH v4 3/5] dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
Date:   Tue, 18 Feb 2020 23:45:31 +0530
Message-Id: <1582049733-17050-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582049733-17050-1-git-send-email-tdas@codeaurora.org>
References: <1582049733-17050-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Modem Subsystem clock provider have a bunch of generic properties
that are needed in a device tree. Add a YAML schemas for those.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
new file mode 100644
index 0000000..db0080e
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
+               <&gcc GCC_MSS_NAV_AXIS_CLK>,
+               <&gcc GCC_MSS_CFG_AHB_CLK>;
+      clock-names = "gcc_mss_mfab_axis",
+                    "gcc_mss_nav_axi",
+                    "cfg_ahb";
+      #clock-cells = <1>;
+    };
+...
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
