Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E6C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9608120716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="iuWu0Omi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgICW1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgICW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:27:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15BC06124F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:27:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f2so4686546qkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnL3R1v8CTVriwJIqi1WnqU9teq6FSMSn+l/wAbEFwk=;
        b=iuWu0OmiFD90d5QkClxiUiwP8APLv0M9gWVOeooMRM2Dxmu1bO0v18LCdbRF225H7O
         kCio2dfQpuSBWGn7saM3dLwaWBL1/RWFsio/0pqWAafq7mrJRD0CmaW+DktYOSYd/YqV
         Gy4AYxH/QvM1C/nSKUuhOaNcUr4i+hI/ykSyNzNODnZyLO5Av4J5mrd9MJU1x94Qxgh/
         cax787yj+UMTSQlm3SfJf2YE6aPyUQHfywq4xKoMtJ3BTjzu7ymnb7d1NxXsSUUueD4x
         X64zrFU8Dtw0iuCaXcYaNB3VmMkYCNbkoo8k7UZiWfLL96XkuA6uVzS8H2sevRddTQ06
         AhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnL3R1v8CTVriwJIqi1WnqU9teq6FSMSn+l/wAbEFwk=;
        b=hMImzBXoJ/S8kTgzd0gi+cvjI92sVqs7noRE+gDQSLSWcJPqE2op17dwxaRmhw0gS8
         Cn3x7FvrHW5Dsuctf76yY9tYkFYIHYR0djOVvTidN1Mjq+aylc670VXrF1F5AzSZehfw
         RZjCBqEF2sUsMuIbpDMebTgkBTTN7qfqq8khgetpYHh7lpTcB1JgGPYiAxH++MFGS3sl
         ezi8EVAyXNLgVS/xhoqagbTVK+EDxUfR/wNHjdJbio7dM2lnyH++scpXzjsStfFJO+h6
         8ckxUPprlNEDZkzY7JXS/EHzsFOAgll72blYLhIgL5xdQaW1fo5+XHQV5gKIUS0PIDiT
         V1fA==
X-Gm-Message-State: AOAM531HX9iiuymtndTcH5hQSB6qY2w8JFO6MN73Z5wc13yICya5AOnP
        CCB1QQGsIwdAqQ1UR+3pccGmwQ==
X-Google-Smtp-Source: ABdhPJw8qjuV9VdYzh9/7C3jiqur+p4pync+TFIU66TMdPE/HeIFbW3FOqdpEuxhoX+MLStrD/IXjQ==
X-Received: by 2002:a37:9a85:: with SMTP id c127mr4143330qke.139.1599172040160;
        Thu, 03 Sep 2020 15:27:20 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y30sm3217157qth.7.2020.09.03.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:27:19 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/7] dt-bindings: clock: Introduce QCOM SM8250 display clock bindings
Date:   Thu,  3 Sep 2020 18:26:13 -0400
Message-Id: <20200903222620.27448-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200903222620.27448-1-jonathan@marek.ca>
References: <20200903222620.27448-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/clock/qcom,dispcc.yaml           |  4 +-
 .../dt-bindings/clock/qcom,dispcc-sm8250.h    | 66 +++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8250.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
index 5b5c7fa6375e..0b905a4e9ada 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
@@ -11,12 +11,13 @@ maintainers:
 
 description: |
   Qualcomm display clock control module which supports the clocks, resets and
-  power domains on SDM845/SC7180/SM8150.
+  power domains on SDM845/SC7180/SM8150/SM8250.
 
   See also:
     dt-bindings/clock/qcom,dispcc-sdm845.h
     dt-bindings/clock/qcom,dispcc-sc7180.h
     dt-bindings/clock/qcom,dispcc-sm8150.h
+    dt-bindings/clock/qcom,dispcc-sm8250.h
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - qcom,sdm845-dispcc
       - qcom,sc7180-dispcc
       - qcom,sm8150-dispcc
+      - qcom,sm8250-dispcc
 
   # NOTE: sdm845.dtsi existed for quite some time and specified no clocks.
   # The code had to use hardcoded mechanisms to find the input clocks.
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8250.h b/include/dt-bindings/clock/qcom,dispcc-sm8250.h
new file mode 100644
index 000000000000..fdaca6ad5c85
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm8250.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM8250_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_MDSS_AHB_CLK			0
+#define DISP_CC_MDSS_AHB_CLK_SRC		1
+#define DISP_CC_MDSS_BYTE0_CLK			2
+#define DISP_CC_MDSS_BYTE0_CLK_SRC		3
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC		4
+#define DISP_CC_MDSS_BYTE0_INTF_CLK		5
+#define DISP_CC_MDSS_BYTE1_CLK			6
+#define DISP_CC_MDSS_BYTE1_CLK_SRC		7
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC		8
+#define DISP_CC_MDSS_BYTE1_INTF_CLK		9
+#define DISP_CC_MDSS_DP_AUX1_CLK		10
+#define DISP_CC_MDSS_DP_AUX1_CLK_SRC		11
+#define DISP_CC_MDSS_DP_AUX_CLK			12
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC		13
+#define DISP_CC_MDSS_DP_LINK1_CLK		14
+#define DISP_CC_MDSS_DP_LINK1_CLK_SRC		15
+#define DISP_CC_MDSS_DP_LINK1_DIV_CLK_SRC	16
+#define DISP_CC_MDSS_DP_LINK1_INTF_CLK		17
+#define DISP_CC_MDSS_DP_LINK_CLK		18
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC		19
+#define DISP_CC_MDSS_DP_LINK_DIV_CLK_SRC	20
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK		21
+#define DISP_CC_MDSS_DP_PIXEL1_CLK		22
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC		23
+#define DISP_CC_MDSS_DP_PIXEL2_CLK		24
+#define DISP_CC_MDSS_DP_PIXEL2_CLK_SRC		25
+#define DISP_CC_MDSS_DP_PIXEL_CLK		26
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC		27
+#define DISP_CC_MDSS_ESC0_CLK			28
+#define DISP_CC_MDSS_ESC0_CLK_SRC		29
+#define DISP_CC_MDSS_ESC1_CLK			30
+#define DISP_CC_MDSS_ESC1_CLK_SRC		31
+#define DISP_CC_MDSS_MDP_CLK			32
+#define DISP_CC_MDSS_MDP_CLK_SRC		33
+#define DISP_CC_MDSS_MDP_LUT_CLK		34
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK		35
+#define DISP_CC_MDSS_PCLK0_CLK			36
+#define DISP_CC_MDSS_PCLK0_CLK_SRC		37
+#define DISP_CC_MDSS_PCLK1_CLK			38
+#define DISP_CC_MDSS_PCLK1_CLK_SRC		39
+#define DISP_CC_MDSS_ROT_CLK			40
+#define DISP_CC_MDSS_ROT_CLK_SRC		41
+#define DISP_CC_MDSS_RSCC_AHB_CLK		42
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK		43
+#define DISP_CC_MDSS_VSYNC_CLK			44
+#define DISP_CC_MDSS_VSYNC_CLK_SRC		45
+#define DISP_CC_PLL0				46
+#define DISP_CC_PLL1				47
+
+/* DISP_CC Reset */
+#define DISP_CC_MDSS_CORE_BCR			0
+#define DISP_CC_MDSS_RSCC_BCR			1
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC				0
+
+#endif
-- 
2.26.1

