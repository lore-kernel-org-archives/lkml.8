Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8C8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CE020708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="16seydNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGINyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGINyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:54:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F16C08E806
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:54:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so1803805qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCgHEsBBtZSFoBu+aV+BX/+uLjnGdbEDUEuvLQsLxp4=;
        b=16seydNw/4DtTg/pc8vaA5f7yQDhw/HnM+hijTL74doV/VGhVCqRaB9IynslkGa8x9
         8hU3SjSfLiiMtkgJpwfksz737zzoEntU/fRuscuGDYTJQ9OewftIi+FsF3GBqg5z+6pL
         6ZUe1+l+7EZXlYNdJDEpbIsZMAYdbUF5yaTOpGBF5nhFzxA1v483Wq2BvpkXjnj9/cS+
         GQTO2gqf9fbzDjIAqyb08brE8Rg8rIiCdscSzV6mciTLwXviIZqE/Nez/T6+F3ALVtkU
         rDheRW126FU1OriqmcOd/vG/ovY2+84h+zlQT1l0/5V5GhDRbWmhU1yIwsTrjnfQoWmZ
         iGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCgHEsBBtZSFoBu+aV+BX/+uLjnGdbEDUEuvLQsLxp4=;
        b=OqdLmWGh1wiI3C8h/PgXPuioVsXYI399jszxs8LmBp5GM6QGTp7PTjCVXhKNI7MyhZ
         R9SI7LeadQm61/IXMrjDWJupUeoJSKXbDb0biHNG0PoRGkmFPRxxVkJydYCSZHFn1K3l
         OZe2DdTNkjVoihCFxtka1tf310ZG+vys3IN9FtJ1bzBmvWtEdSlWDqtjqAd4pwqRNDvS
         Mrovyc08w2EGKyGrIZVi90GFAcSSAmEeJ7USVOQzhsXzhZ+HdJedbpCtV8UbZwbfn5bd
         v7rtAVLO47iNgb4lSU1bpLIiwok/dJYJrk2aW11c8U/ylFFPxNXlTmTBbBz9Pfj+qLos
         SGOg==
X-Gm-Message-State: AOAM533SJR9Q4L0RS3gZ/7VCgWk832jSjgRMsEAdjsWumndlUuvojxBk
        9wCRj5ZAcRCmoekSgslNzK4OgQ==
X-Google-Smtp-Source: ABdhPJytlYFL4wt5+VUeIXGOQ6piFPPDaVIhgbiaK9pRMXHy3SoLhPxLso0EDzbu64xXqRq/uEnlwQ==
X-Received: by 2002:a05:620a:238:: with SMTP id u24mr63685178qkm.168.1594302878110;
        Thu, 09 Jul 2020 06:54:38 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 130sm3632735qkn.82.2020.07.09.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:54:37 -0700 (PDT)
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
Subject: [PATCH v3 07/14] dt-bindings: clock: add SM8150 QCOM Graphics clock bindings
Date:   Thu,  9 Jul 2020 09:52:38 -0400
Message-Id: <20200709135251.643-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200709135251.643-1-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM8150 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  4 ++-
 include/dt-bindings/clock/qcom,gpucc-sm8150.h | 33 +++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index aab6bef79771..3e064ed0e0ea 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -11,17 +11,19 @@ maintainers:
 
 description: |
   Qualcomm graphics clock control module which supports the clocks, resets and
-  power domains on SDM845/SC7180.
+  power domains on SDM845/SC7180/SM8150.
 
   See also:
     dt-bindings/clock/qcom,gpucc-sdm845.h
     dt-bindings/clock/qcom,gpucc-sc7180.h
+    dt-bindings/clock/qcom,gpucc-sm8150.h
 
 properties:
   compatible:
     enum:
       - qcom,sdm845-gpucc
       - qcom,sc7180-gpucc
+      - qcom,sm8150-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8150.h b/include/dt-bindings/clock/qcom,gpucc-sm8150.h
new file mode 100644
index 000000000000..c5b70aad7770
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8150.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_APB_CLK			2
+#define GPU_CC_CX_GMU_CLK			3
+#define GPU_CC_CX_SNOC_DVM_CLK			4
+#define GPU_CC_CXO_AON_CLK			5
+#define GPU_CC_CXO_CLK				6
+#define GPU_CC_GMU_CLK_SRC			7
+#define GPU_CC_GX_GMU_CLK			8
+#define GPU_CC_PLL1				9
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		1
+#define GPUCC_GPU_CC_GMU_BCR			2
+#define GPUCC_GPU_CC_GX_BCR			3
+#define GPUCC_GPU_CC_SPDM_BCR			4
+#define GPUCC_GPU_CC_XO_BCR			5
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
2.26.1

