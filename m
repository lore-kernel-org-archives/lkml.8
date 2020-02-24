Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D86C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F320828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="s6hbGaOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBXKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:38:56 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:16209 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727521AbgBXKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:38:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582540734; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CIYjt4lnjoJu9GaTu0LPPzz57u8zb6c0g+zAu6aEuBU=; b=s6hbGaOjWvnxbLmIhUyAca/rs93LAHnc3cX4S0FFfZoEFZOJA6Ita7FlopwnaRY76lodw8h7
 8aZvB/OHpTmYwzMZjmdzSTfVdzCaapLPIUR7eOFLOIZUJxMEbWFiJcYrsbmmEDyqtzjgkkDd
 0jRmb10RQVvycEFv7+1Mumq1rpc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e53a7be.7fc05355e0a0-smtp-out-n01;
 Mon, 24 Feb 2020 10:38:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 029DAC4479D; Mon, 24 Feb 2020 10:38:53 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D99AC447A4;
        Mon, 24 Feb 2020 10:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D99AC447A4
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
Subject: [PATCH v5 3/5] dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
Date:   Mon, 24 Feb 2020 16:08:21 +0530
Message-Id: <1582540703-6328-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582540703-6328-1-git-send-email-tdas@codeaurora.org>
References: <1582540703-6328-1-git-send-email-tdas@codeaurora.org>
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
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
