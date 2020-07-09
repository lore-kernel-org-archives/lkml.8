Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C896520708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="OP/2gXgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGINyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgGINyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:54:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E196CC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:54:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b25so1708190qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sajExZQ2Jao7Uovy75CI2ebqOruOQ+ockQo9YmERUIU=;
        b=OP/2gXgWG72L4Q3xFAxDitDMJvU9eVBbgLj+tM0fDPHoYDAMxcZIDWIb2YSw5bob7Z
         qMZ04qgzgyT6uuK3SersTBD1ZxpMkWP2k0EWH2EO4OGHQOC/A8Mz5tuEqkmS7aXlCJlP
         HFNMr55/viIQavNARK1Ht8CHKT02/y3Vqlb3EwG5Ulet5UHvAWrrYyeqNIeYfqQ2zgrp
         rlmWv3B8Im1rkQyqq9ulRwML8ku29gvorXnzW2V1XBi1KHrv6cH+7I4F+i+ftQ5e9WGj
         y4CwMO4U+dTVk496FO76vhfQGpSONG477nuj5W53CDSs7DNHQvE3OhdBe4teXus2wXUH
         vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sajExZQ2Jao7Uovy75CI2ebqOruOQ+ockQo9YmERUIU=;
        b=acjL1PRJO3ROdNMXy4jtjWp9Xff52eXB+LPABSmI22ioeN73vIPCmYzc6n8IeN3UTm
         KZ0ibL3rnUaHlFbZYvj7ccWA35Iu+rsSpYorKDDEKnE7+i15gz469KYQdvNOTFzgt2BE
         U7XiPaWYRgwfL0zelJbnEB/Onn/wIjPvj5NiIt3e5Ol363bRXhFVQwAJJM40jlpDIoy8
         TNsajT0yC8HAapjR4ebWp8lR3wgd5TpaUhV/fVlolkEQiRzDaXlwwmh5n9tG29tF9XIf
         iPQ9xtbkzhgTt0tq1DO5DM5Hiyo6GZNfbYDhEI0FUYN4lbyCjlX2TTEGZMVSYqRHEWCA
         SXVQ==
X-Gm-Message-State: AOAM530gTF6MguPci6XKv6a475uiRrGJtAnYqcCtlQNSE6p5RmXxU8wG
        01F8Hq9cchiehgmDLiyP8MW4kFDu0b0=
X-Google-Smtp-Source: ABdhPJy2ssse5p6SWQmU/uLhkkMj/lol6JuFrQz50L+3AvTeiQwAx6lXzR3OnfdFS5ClfLQy7n57IQ==
X-Received: by 2002:aed:2492:: with SMTP id t18mr66862700qtc.353.1594302880143;
        Thu, 09 Jul 2020 06:54:40 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 130sm3632735qkn.82.2020.07.09.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:54:39 -0700 (PDT)
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
Subject: [PATCH v3 08/14] dt-bindings: clock: add SM8250 QCOM Graphics clock bindings
Date:   Thu,  9 Jul 2020 09:52:39 -0400
Message-Id: <20200709135251.643-9-jonathan@marek.ca>
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
Qualcomm Technology Inc's SM8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  4 ++-
 include/dt-bindings/clock/qcom,gpucc-sm8250.h | 34 +++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8250.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 3e064ed0e0ea..df943c4c3234 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -11,12 +11,13 @@ maintainers:
 
 description: |
   Qualcomm graphics clock control module which supports the clocks, resets and
-  power domains on SDM845/SC7180/SM8150.
+  power domains on SDM845/SC7180/SM8150/SM8250.
 
   See also:
     dt-bindings/clock/qcom,gpucc-sdm845.h
     dt-bindings/clock/qcom,gpucc-sc7180.h
     dt-bindings/clock/qcom,gpucc-sm8150.h
+    dt-bindings/clock/qcom,gpucc-sm8250.h
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - qcom,sdm845-gpucc
       - qcom,sc7180-gpucc
       - qcom,sm8150-gpucc
+      - qcom,sm8250-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8250.h b/include/dt-bindings/clock/qcom,gpucc-sm8250.h
new file mode 100644
index 000000000000..dc8e387c48ad
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8250.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8250_H
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
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		10
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CX_BCR			1
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		2
+#define GPUCC_GPU_CC_GMU_BCR			3
+#define GPUCC_GPU_CC_GX_BCR			4
+#define GPUCC_GPU_CC_XO_BCR			5
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
2.26.1

